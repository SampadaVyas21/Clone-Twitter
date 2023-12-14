class HomeController < ApplicationController
  
  def index
    if user_signed_in?
      redirect_to tweet_feed_path
    else
      redirect_to  new_user_session_path
    end
  end
  
  def userprofile
    @my_tweets = current_user.tweets
    @my_retweets = current_user.retweets
    @my_all_tweets = @my_tweets + @my_retweets
  end

  def casebtn
    case params[:home_id]
    when 'follower'
      @users = current_user.followers
      render "home/userbutton", :locals => {:page_name => "Followers" }
    when 'following'
      @users = current_user.followees
      render "home/userbutton", :locals => {:page_name => "Followees" }
    when 'sugg'
      @users = User.all
      render "home/userbutton", :locals => {:page_name => "Suggestions" }
    when 'retweets'
      @retweets = Retweet.includes(user: :following_users).where(follows: { follower_id: current_user}).or(Retweet.where(user_id: current_user.id))
      render "retweets/retweet"
    else
      @users = User.all
      render "users/edit"
    end
  end
end