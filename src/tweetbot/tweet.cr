require "./twitter_client"

MESSAGES = {
  "tokyomx" => "TOKYO MX BS11 「ブレンド・S」 はじまるよー #ブレンドS",
  "atx" => "ATX 「ブレンド・S」 はじまるよー #ブレンドS",
  "nico" => "ニコニコ生放送 「ブレンド・S」 はじまるよー #ブレンドS",
  "ameba" => "AmebaTV 「ブレンド・S」 はじまるよー #ブレンドS",
  "bandai" => "バンダイチャンネル 「ブレンド・S」 はじまるよー #ブレンドS",
}

twitter_client = TwitterClient.new
time = Time.new

twitter_client.tweet(MESSAGES["tokyomx"]) if tokyomx?(time)
twitter_client.tweet(MESSAGES["atx"]) if atx?(time)
twitter_client.tweet(MESSAGES["nico"]) if nico?(time)
twitter_client.tweet(MESSAGES["ameba"]) if ameba?(time)
twitter_client.tweet(MESSAGES["bandai"]) if bandai?(time)

def tokyomx?(time)
  time.sunday? && time.hour == 0 && time.minute >=20 && time.minute <= 29
end

def atx?(time)
  time.monday? && time.hour == 19 && time.minute >=50 && time.minute <= 59
end

def nico?(time)
  time.tuesday? && time.hour == 22 && time.minute >=50 && time.minute <= 59
end

def ameba?(time)
  time.tuesday? && time.hour == 23 && time.minute >=20 && time.minute <= 29
end

def bandai?(time)
  time.tuesday? && time.hour == 11 && time.minute >=50 && time.minute <= 59
end