class RetweetsController < ApplicationController

	def retweet
    tweet = Tweet.find_by(id: params[:tweet_id])
    @tweetts = current_user.retweets.create(tweet_id: tweet.id)
    redirect_to tweet_feed_path
  end
end
