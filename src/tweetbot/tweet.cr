require "./twitter_client"

MESSAGES = {
  "tokyomx" => "TOKYO MX 「ブレンド・S」 はじまるよー #ブレンドS",
  "bs11" => "ＢＳ１１ 「ブレンド・S」 はじまるよー #ブレンドS",
}

twitter_client = TwitterClient.new
time = Time.new

twitter_client.tweet(MESSAGES["tokyomx"]) if tokyomx?(time)
twitter_client.tweet(MESSAGES["bs11"]) if bs11?(time)

def tokyomx?(time)
  time.sunday? && time.hour == 0 && time.minute >=19 && time.minute <= 21
end

def bs11?(time)
  time.sunday? && time.hour == 0 && time.minute >=19 && time.minute <= 21
end
