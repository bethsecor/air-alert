class User < ActiveRecord::Base
  has_many :outdoor_alerts
  has_many :indoor_alerts

  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid'])

    user.uid = auth['uid']
    user.name = auth['info']['name']
    user.nickname = auth['info']['nickname']
    user.location = auth['info']['location']
    user.token = auth['credentials']['token']
    user.secret = auth['credentials']['secret']

    user.save
    user
  end

  def tweet(tweet)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_ID']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = token
      config.access_token_secret = secret
    end

    client.update(tweet)
  end
end
