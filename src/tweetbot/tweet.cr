require "./twitter_client"

MESSAGES = [
  "TOKYO MX 「ブレンド・S」 はじまるよー #ブレンドS",
  "ＢＳ１１ 「ブレンド・S」 はじまるよー #ブレンドS",
]

twitter_client = TwitterClient.new
MESSAGES.each do |message|
  twitter_client.tweet(message)
end