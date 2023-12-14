class LikesController < ApplicationController
	before_action :find_tweet
	before_action :find_like, only: [:destroy]

  	def create
  		if already_liked?
    		flash[:notice] = "You can't like more than once"
  		else
    		@tweet.likes.create(user_id: current_user.id)
    		count = @tweet.likescount
    		@tweet.update(likescount: count.to_i + 1)
    	end
    	respond_to do |format|
      format.html 
      format.js # handle ajax request
    end 
    	 redirect_to tweet_feed_path(@tweet)
  	end

  	def destroy
  		if already_liked?
    		@like.destroy
    		count = @tweet.likescount
  		else
  			flash[:notice] = "Cannot unlike"
  		end
  		@tweet.update(likescount: count.to_i - 1)
  		redirect_to tweet_feed_path(@tweet)
	end

  	private
  	def already_liked?
  		Like.where(user_id: current_user.id, tweet_id: params[:tweet_id]).exists?
	end

  	def find_tweet
   	@tweet = Tweet.find(params[:tweet_id])
  	end

  	def find_like
   	@like = @tweet.likes.find(params[:id])
	end
end