class Post < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  after_save :update_counter

  def recent_comments()
    comments.last(5)
  end

  private

  def update_counter
    user.increment!(:posts_counter)
  end
end
