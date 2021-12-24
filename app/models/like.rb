class Like < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  belongs_to :post, foreign_key: :post_id
  
  def self.update_counter(post)
    post.update(likes_counter: (post.likes_counter + 1))
  end
end
