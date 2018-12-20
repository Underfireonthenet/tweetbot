require "google-api-client-cr"
require "./twitter_client"
require "./models/video"

# https://www.googleapis.com/youtube/v3/search?part=id&channelId=UCWzenZSy9GJBcPzdSm-UX5w&order=date

class Notifier
  @channel_infos : Array(NamedTuple(channel_id: String, tags: String))
  @twitter_client : TwitterClient
  @youtube : Google::Apis::YoutubeV3::YouTubeService

  def initialize(channel_infos)
    @channel_infos = channel_infos
    @twitter_client = TwitterClient.new
    @youtube = Google::Apis::YoutubeV3::YouTubeService.new
  end

  def youtube_channel_info(channel_id)
    @youtube.list_searches("id,snippet", channel_id: channel_id, order: "date", max_results: 5)
  end

  def notify_all
    @channel_infos.each do |channel_info|
      notify(channel_info[:channel_id], channel_info[:tags])
    end
  end

  def notify(channel_id, tags)
    channel_info = youtube_channel_info(channel_id)
    return unless channel_info
    video_id = channel_info["items"][0]["id"]["videoId"]
    title = channel_info["items"][0]["snippet"]["title"]
    return unless video_id
    video = Video.find_by(video_id: video_id.to_s)
    return if video
    Video.create!(channel_id: channel_id, video_id: video_id.to_s)
    message = "#{title} https://www.youtube.com/watch?v=#{video_id.to_s} #{tags}"
    @twitter_client.tweet(message)
  end
end

channel_infos = [{channel_id: "UCWzenZSy9GJBcPzdSm-UX5w", tags: "#モンスト #モンストアニメ"}]
notifier = Notifier.new(channel_infos)
notifier.notify_all
