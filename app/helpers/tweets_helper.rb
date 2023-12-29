module TweetsHelper
	def check_retweet
		@tweet = @tweets.find_by(params[:id])
		if @tweet.class.name == "Retweet" 
			"This is a retweet"
		end
	end

	def random_chartkick_id
  	return 'chart-#'+(Random.rand(10000)).to_s
	end
end
