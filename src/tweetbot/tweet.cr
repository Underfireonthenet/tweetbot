require "google-api-client-cr"
require "./twitter_client"
require "db"
require "pg"
database_url = ENV["DATABASE_URL"]? || "postgres://preface@localhost:5432/tweetbot_development"

twitter_client = TwitterClient.new
youtube = Google::Apis::YoutubeV3::YouTubeService.new

# https://www.googleapis.com/youtube/v3/search?part=id&channelId=UCWzenZSy9GJBcPzdSm-UX5w&order=date
result = youtube.list_searches("id,snippet", channel_id: "UCWzenZSy9GJBcPzdSm-UX5w", order: "date", max_results: 5)
channel_id = "UCWzenZSy9GJBcPzdSm-UX5w"
video_id = result["items"][0]["id"]["videoId"].to_s
title = result["items"][0]["snippet"]["title"]

db = DB.open(database_url)

sql = "select id, channel_id, video_id from videos where video_id = $1::text"
params = [] of String
params << video_id
videos = [] of Hash(String, String | Int32)
db.query(sql, params) do |rs|
  rs.each do
    video = {} of String => String | Int32
    video["id"] = rs.read(Int32)
    video["title"] = rs.read(String)
    video["content"] = rs.read(String)
    videos << video
  end
end

unless videos.size == 0
  new_params = [] of String
  new_params << videos.first["channel_id"].to_s
  new_params << videos.first["video_id"].to_s
  db.exec("insert into videos(channel_id, video_id) values($1::text, $2::text)", new_params)
  message = "#{title} https://www.youtube.com/watch?v=#{video_id} #モンスト #モンストアニメ"
  twitter_client.tweet(message)
end
db.close