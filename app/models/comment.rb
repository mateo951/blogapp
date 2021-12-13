class Comments < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_counter
    post.update(comments_counter: post.comments_counter + 1)
  end
end