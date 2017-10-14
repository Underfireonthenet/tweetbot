require "kemal"
require "./tweetbot/*"

#twitter_client = TwitterClient.new

get "/tweet" do |env|
  #twitter_client.tweet("test")
  render "src/tweetbot/views/tweet.ecr"
end

Kemal.run