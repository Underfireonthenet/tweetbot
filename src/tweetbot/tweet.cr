require "google-api-client-cr"
require "./twitter_client"
require "db"
require "pg"
require "granite/adapter/pg"
database_url = ENV["DATABASE_URL"]? || "postgres://preface@localhost:5432/tweetbot_development"
Granite::Adapters << Granite::Adapter::Pg.new({name: "pg", url: database_url})
require "./models/video"

twitter_client = TwitterClient.new
youtube = Google::Apis::YoutubeV3::YouTubeService.new

# https://www.googleapis.com/youtube/v3/search?part=id&channelId=UCWzenZSy9GJBcPzdSm-UX5w&order=date
result = youtube.list_searches("id,snippet", channel_id: "UCWzenZSy9GJBcPzdSm-UX5w", order: "date", max_results: 5)
channel_id = "UCWzenZSy9GJBcPzdSm-UX5w"
video_id = result["items"][0]["id"]["videoId"].to_s
title = result["items"][0]["snippet"]["title"]

video = Video.find_by(video_id: video_id)

unless video
  new_video = Video.new(channel_id: channel_id, video_id: video_id)
  new_video.save!
  message = "#{title} https://www.youtube.com/watch?v=#{video_id} #モンスト #モンストアニメ"
  twitter_client.tweet(message)
end
