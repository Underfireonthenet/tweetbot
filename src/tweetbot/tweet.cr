require "./twitter_client"

MESSAGES = [
  "ブレンド・S はじまるよー #ブレンドS",
]

twitter_client = TwitterClient.new
twitter_client.tweet("tweet bot test")
