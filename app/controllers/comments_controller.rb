class CommentsController < ApplicationController
	  
  def index
    @tweett = Tweet.find(params[:tweet_id])
    @com = @tweett.comments
   end

	def new
    @tweet = Tweet.find_by(params[:tweet_id])
    @comment = Comment.new
  end
	
	def create
    following_tweet = Tweet.find(params[:tweet_id])
    @comment = following_tweet.comments.new(comment_params)
    if @comment.save
    	redirect_to tweet_feed_path
    else
    	flash[:notice] = @comment.errors.full_messages.to_sentence
    	redirect_to tweet_feed_path
    end
  end

  private
  def comment_params
    if params[:body].present?
      params.permit(:body, :tweet_id).merge(:user_id => current_user.id)
    else
      params.require(:comment).permit(:body,:tweet_id).merge(:user_id => current_user.id)
    end
  end

end
