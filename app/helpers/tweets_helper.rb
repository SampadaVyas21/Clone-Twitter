module TweetsHelper
	def check_retweet
		@tweet = @tweets.find_by(params[:id])
		if @tweet.class.name == "Retweet" 
			"This is a retweet"
		end
	end
end
