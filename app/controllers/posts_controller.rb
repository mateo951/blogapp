class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = current_user
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comments = @post.comments.all
    authorize! :read, @post
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
    else
      flash[:error] = 'Error:  Post could not be saved'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @post = Post.find_by_id(params[:post_id])
    @user = User.find(params[:user_id])
    if @post.destroy
      flash[:success] = 'Post destroyed successfully'
    else
      flash[:error] = 'Error:  Post could not be destroyed'
    end
    redirect_back(fallback_location: root_path)
  end

  def post_params
    params.require(:post).permit(:title, :text, :author_id, :comments_counter, :likes_counter)
  end
end
