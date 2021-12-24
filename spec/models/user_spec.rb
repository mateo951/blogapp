require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Mateo', photo: 'photo', bio: 'bio', posts_counter: 0) }

  describe 'Invalid input' do
    before :each do
      subject.save
    end

    it 'name exists' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'posts_counter must be a integer' do
      subject.posts_counter = 'sadasdsa'
      expect(subject).to_not be_valid
    end

    it 'posts-counter greater than or equal to 0' do
      subject.posts_counter = -2
      expect(subject).to_not be_valid
    end
  end

  describe 'Valid input' do
    before :each do
      subject.save
    end

    it 'name exists' do
      expect(subject).to be_valid
    end

    it 'posts_counter must be a integer' do
      subject.posts_counter = 3
      expect(subject).to be_valid
    end

    it 'posts-counter greater than or equal to 0' do
      subject.posts_counter = 5
      expect(subject).to be_valid
    end
  end

  describe 'recent_posts' do
    it 'should retrieve 5 most recents posts' do
      user = User.create(name: 'Mateo', photo: 'photo', bio: 'bio', posts_counter: 0)
      posts = []
      (1..5).each do |_i|
        posts << Post.create(title: 'Post #', text: 'something good', comments_counter: 0, likes_counter: 0,
                             author_id: user.id)
      end

      expect(User.first.recent_posts.length).to eq(3)
    end
  end
end
