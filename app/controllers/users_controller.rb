class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = current_user
    @posts = @user.recent_posts
  end
end
