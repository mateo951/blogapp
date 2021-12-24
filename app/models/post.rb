class Post < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments()
    comments.last(5)
  end

  def self.update_counter(id)
    @user = User.find(id)
    @user.update(posts_counter: (@user.posts_counter + 1))
  end
end
