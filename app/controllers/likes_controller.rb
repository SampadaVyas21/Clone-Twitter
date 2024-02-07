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
	    render json: @tweet.likes.count
  	end

  	def destroy
  		if already_liked?
    		@like.destroy
    		count = @tweet.likescount
  		else
  			flash[:notice] = "Cannot unlike"
  		end
  		@tweet.update(likescount: count.to_i - 1)
  		render json: @tweet.likes.count
		end

		def check
			if already_liked?
			pre_like = Like.where(user_id: current_user.id, tweet_id: params[:tweet_id]).ids
				render json: pre_like.to_a
			else
				render json: false
			end
		end

  	private
  	def already_liked?
  		Like.where(user_id: current_user.id, tweet_id: params[:tweet_id]).exists?
	end

  	def find_tweet
   	@tweet = Tweet.find_by(id: params[:tweet_id])
  	end

  	def find_like
   	@like = @tweet.likes.find_by(id: params[:id])
	end
end