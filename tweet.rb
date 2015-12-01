require 'slack-notifier'
require 'twitter'

class Tweet < ActiveRecord::Base
  validates_uniqueness_of :text

  def self.client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end
  end

  def self.tweet(text)
    client.update(format_tweet(text))
  end

  def self.format_tweet(text)
    string = "“#{text}” – @realDonaldTrump"
    string.length < 117 ? string += " #MakeAmericaGreatAgain" : string
  end

  def self.send_random_tweet
    tweet = where(tweeted: false).sample
    if tweet
      tweet(tweet.text)
      tweet.update_attributes tweeted: true
    end
  end

  def self.batch_create(tweet_lines)
    tweet_lines.gsub("\r", "").split("\n").map do |line|
      Tweet.create(
        text: line
      )
    end
  end

  def notify
    icon = %w(
      :death:
      :cry:
      :bomb:
      :boom:
    )
    Slack::Notifier.new(
      ENV["SLACK_WEBHOOK_URL"],
      channel: "too-hot-for-wp",
      username: "WikiBot",
      icon_emoji: ':wikipedia:',
    ).ping("#{icon.sample} [#{title}](#{page_url}) #{icon.sample}")
  end

end
