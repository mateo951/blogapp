class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    @post = Post.find_by_id(params[:post_id])
    @post.comments.create(comment_params.merge(author_id: current_user.id))
    redirect_back(fallback_location: root_path)
    Comment.update_counter(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end
end
