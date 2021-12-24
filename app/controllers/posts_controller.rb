class PostsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comments = @post.comments.all
  end

  def new
    @user = current_user
    @post = Post.new
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    @user = current_user
    @post = @user.posts.create(post_params)
    if @post.save
      flash[:success] = 'Post saved successfully'
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = 'Error:  Post could not be saved'
      redirect_back(fallback_location: root_path)
    end
  end

  def post_params
    params.require(:post).permit(:title, :text, :author_id, :comments_counter, :likes_counter)
  end
end
