class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.present? 
      @user.update(user_params)
      redirect_to edit_user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :name, :bio, :bluetick, :photo, :search)
  end
end
