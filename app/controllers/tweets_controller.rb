class TweetsController < ApplicationController

   helper_method :TweetsHelper

  def index
    @tweets = Tweet.all
  end

  def new
  end
  
  def create
    @tweet = current_user.tweets.create(tweet_params)
    if @tweet.save
      @tweet.update(tweet_params)
      redirect_to tweet_feed_path
    else
      flash[:notice] = @tweet.errors.full_messages.to_sentence
      redirect_to tweet_feed_path
    end
  end

  def feed
    @tweets = Tweet.includes(user: :following_users).where(follows: { follower_id: current_user}).or(Tweet.where(user_id: current_user))
    @tweet = Tweet.new
    @tweets = @tweets.joins(:user).where("users.name like ? OR lower(content) like ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?   
    @retweets = Retweet.includes(user: :following_users).where(follows: { follower_id: current_user}).or(Retweet.where(user_id: current_user.id))
    @all_tweets = @tweets + @retweets
  end
  
  def retweeting
    @tweets = Tweet.find_by(id: params[:tweet_id])
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content, :likescount, :tweet_image, images: [],comments_attributes: [:body])
  end
end

