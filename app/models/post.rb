class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def update_counter
    user.update(posts_counter: user.posts_counter + 1)
  end

  def recent_comments()
    comments.last(3)
  end
end
