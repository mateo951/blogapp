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
    if @like.save
      flash[:success] = 'Like saved successfully'
      redirect_back(fallback_location: root_path)
      Like.update_counter(@post)
    else
      flash.now[:error] = 'Like could not be saved'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def like_params
    params.require(:like).permit(:author_id, :post_id)
  end
end
