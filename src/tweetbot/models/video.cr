require "db"
require "pg"
require "granite/adapter/pg"

database_url = ENV["DATABASE_URL"]? || "postgres://preface@localhost:5432/tweetbot_development"
Granite::Adapters << Granite::Adapter::Pg.new({name: "pg", url: database_url})

class Video < Granite::Base
  adapter pg
  field channel_id : String
  field video_id : String
end