# Remember that config.omniauth adds omniauth provider middleware to your application. This means you should not add this provider middleware again in config/initializers/omniauth.rb as they'll clash with each other and result in always-failing authentication.

require 'twitter'

TWITTER_CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_API_KEY"]
  config.consumer_secret     = ENV["TWITTER_API_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
end

