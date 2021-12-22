class LikesController < ApplicationController
  def new
    @like = Like.new
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    @user = current_user
    @post = Post.find_by_id(params[:post_id])
    @like = Like.create!(like_params)
    redirect_back(fallback_location: root_path)
    Like.update_counter(@post)
  end

  private

  def like_params
    params.require(:like).permit(:author_id, :post_id)
  end
end
