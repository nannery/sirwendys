require 'cuba'
require 'twitter'

CLIENT = Twitter::REST::Client.new do |c|
  c.consumer_key        = ENV['TWITTER_CONSUMER_API_KEY']
  c.consumer_secret     = ENV['TWITTER_CONSUMER_API_SECRET']
  c.access_token        = ENV['TWITTER_ACCESS_TOKEN']
  c.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
end

CUSTOMER = 'realDonaldTrump'
COMPANY  = 'SirWendys'
COMMENT  = "@#{CUSTOMER} Excuse me, sir, this is a Wendy's"

def let_the_customer_know_where_he_or_she_is
  customer_latest_tweet = CLIENT.user_timeline(CUSTOMER).first
  our_latest_tweet      = CLIENT.user_timeline(COMPANY).first

  if our_latest_tweet.in_reply_to_status_id != customer_latest_tweet.id
    CLIENT.update(COMMENT, in_reply_to_status_id: customer_latest_tweet.id)
  end
end

Cuba.define do
  on get do
    on root do
      let_the_customer_know_where_he_or_she_is
      res.write 'Sir, this is a Wendy\'s'
    end
  end
end
