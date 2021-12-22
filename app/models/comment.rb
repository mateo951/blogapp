class Comment < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  belongs_to :post, foreign_key: :post_id

  def self.update_counter(post)
    post.update(comments_counter: (post.comments_counter + 1))
  end
end
