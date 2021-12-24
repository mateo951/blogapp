require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Invalid input' do
    it 'title exists' do
      user = User.create(name: 'Mateo', photo: 'photo', bio: 'bio', posts_counter: 0)
      post = Post.create(title: '   ', text: 'test', comments_counter: 0, likes_counter: 0, author_id: user.id)
      post.title = nil
      expect(post).to_not be_valid
    end

    it 'title max length meets 250' do
      user = User.create(name: 'Mateo', photo: 'photo', bio: 'bio', posts_counter: 0)
      post = Post.create(title: ('a' * 260).to_s, text: 'test', comments_counter: 0, likes_counter: 0,
                         author_id: user.id)
      expect(post).to_not be_valid
    end

    it 'comments_counter must be a integer' do
      user = User.create(name: 'Mateo', photo: 'bio', bio: 'bio', posts_counter: 0)
      post = Post.create(title: 'Test', text: 'test', comments_counter: 'test', likes_counter: 0, author_id: user.id)
      expect(post).to_not be_valid
    end

    it 'comments_counter must be greater or equal to 0' do
      user = User.create(name: 'Mateo', photo: 'bio', bio: 'bio', posts_counter: 0)
      post = Post.create(title: 'Test', text: 'test', comments_counter: -5, likes_counter: 0, author_id: user.id)
      expect(post).to_not be_valid
    end

    it 'likes_counter must be a integer' do
      user = User.create(name: 'Mateo', photo: 'bio', bio: 'bio', posts_counter: 0)
      post = Post.create(title: 'Test', text: 'test', comments_counter: 0, likes_counter: 'test', author_id: user.id)
      expect(post).to_not be_valid
    end

    it 'likes_counter must be greater or equal to 0' do
      user = User.create(name: 'Mateo', photo: 'bio', bio: 'bio', posts_counter: 0)
      post = Post.create(title: 'Test', text: 'test', comments_counter: 0, likes_counter: -5, author_id: user.id)
      expect(post).to_not be_valid
    end
  end

  describe 'testing comments ' do
    it 'post.recents_comments => should retrieve 5 most recents comments' do
      user = User.create(name: 'Mateo', photo: 'bio', bio: 'bio', posts_counter: 0)
      post = Post.create(title: 'Test', text: 'test', comments_counter: 0, likes_counter: 0, author_id: user.id)
      comments = []
      (1..10).each do |_i|
        comments << Comment.create(text: 'Test', author_id: user.id, post_id: post.id)
      end

      expect(Post.first.recent_comments.length).to eq(5)
    end
  end
end
