class PostsController < ApplicationController
  def index
    @user = current_user
    @posts = @user.recent_posts
  end

  def show
    @user = current_user
    @post = @user.posts.find(params[:id])
    @comments = @post.comments.all
  end
end
