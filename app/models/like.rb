class Like < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  belongs_to :post, foreign_key: :post_id
  after_save :update_counter

  private

  def update_counter
    post.increment!(:likes_counter)
  end
end
