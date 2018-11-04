require 'cuba'
require 'twitter'

CLIENT = Twitter::REST::Client.new do |c|
  c.consumer_key        = ENV['TWITTER_CONSUMER_API_KEY']
  c.consumer_secret     = ENV['TWITTER_CONSUMER_API_SECRET']
  c.access_token        = ENV['TWITTER_ACCESS_TOKEN']
  c.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
end

CUSTOMER = 'realDonaldTrump'
COMMENT  = "Sir, this is a Wendy's"

def last_checked_time
  Time.at(Time.now.to_i - 60)
end

def does_the_customer_know_where_he_or_she_is?
  latest_tweet = CLIENT.user_timeline(CUSTOMER).first
  #if latest_tweet.created_at > last_checked_time
    CLIENT.update(COMMENT, in_reply_to_status_id: latest_tweet.id)
  #end
end

Cuba.define do
  on get do
    on root do
      does_the_customer_know_where_he_or_she_is?
      res.write 'Sir, this is a Wendy\'s'
    end
  end
end
