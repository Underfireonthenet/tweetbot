require "twitter-crystal"

class TwitterClient
	@client : Twitter::REST::Client
  def initialize
    consumer_key                 = ENV["CONSUMER_KEY"]
    consumer_secret              = ENV["CONSUMER_SECRET"]
    access_token                 = ENV["ACCESS_TOKEN"]
    access_token_secret          = ENV["ACCESS_TOKEN_SECRET"]
    @client                      = Twitter::REST::Client.new(consumer_key, consumer_secret, access_token, access_token_secret)
  end

  def tweet(message)
    @client.update(message)
  end
end