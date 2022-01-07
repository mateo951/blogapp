require 'rails_helper'
require './spec/integrations/integration_mocks'

RSpec.describe 'user index view', type: :feature do
  include Mocks
  before :each do
    @users = create_users
    @posts = create_posts(@users)
    @post = @users[0].recent_posts[0]
    create_likes_comments(@users, @posts)
    visit new_user_session_path

    within('form') do
      fill_in 'user_email', with: 'foo1@foo.com'
      fill_in 'user_password', with: 'admin123'
    end
    click_button 'Log in'
    visit "/users/#{@users[0].id}/posts/#{@post.id}"
  end

  context 'displaying post info' do
    it "can see post's title" do
      expect(page).to have_content @post.id.to_s
    end
    it "can see post's author" do
      expect(page).to have_content "by #{@users[0].name}"
    end
    it 'can see comments counter' do
      expect(page).to have_content "Comments: #{@post.comments_counter}"
    end
    it 'can see likes counter' do
      expect(page).to have_content "Likes:#{@post.likes_counter}"
    end
    it "can see post's text" do
      expect(page).to have_content 'This is post number'
    end
    it "can see post's comment username" do
      expect(page).to have_content 'Felipe:'
    end
    it 'can see the username of each commentor.' do
      comments = @post.comments
      comments.each do |comment|
        expect(page).to have_content comment.user.name
        expect(page).to have_content comment.text
      end
    end
  end
end
