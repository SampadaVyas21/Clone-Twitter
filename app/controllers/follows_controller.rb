class FollowsController < ApplicationController
  before_action :find_user
  
  def follow
    current_user.followees << @user
    redirect_back(fallback_location: user_path(@user))
  end

  def unfollow
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back(fallback_location: user_path(@user))
  end

  private
    def find_user
      @user = User.find(params[:id])
    end
end
