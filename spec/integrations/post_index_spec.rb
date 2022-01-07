require 'rails_helper'
require './spec/integrations/integration_mocks'

RSpec.describe 'user index view', type: :feature do
  include Mocks  
  before :each do
    @users = create_users
    @posts = create_posts(@users)
    @post = @users[1].recent_posts[0]
    create_likes_comments(@users, @posts)
    visit new_user_session_path

    within('form') do
      fill_in 'user_email', with: 'foo2@foo.com'
      fill_in 'user_password', with: 'admin123'
    end
    click_button 'Log in'
    click_on('Felipe')
    # click_link("Post ##{@users[1].recent_posts[0].id}")
  end
  context 'displaying user info' do
    it 'user image is displayed' do
      expect(page).to have_selector('img')
    end
    it 'user name is displayed' do
      expect(page).to have_content(@users[1].name)
    end
    it 'user number of post is displayed' do 
      expect(page).to have_content "Number of posts: #{@users[1].posts_counter}"
    end
  end
  context 'displaying post info' do
    it "can see post's title" do
      expect(page).to have_content "#{@post.title}"
    end
    it "can see post's text" do
      expect(page).to have_content "This is post number"
    end
  end
  context 'displaying post info' do
    it 'can see recents comment for the post' do
      post.recent_comments do |comment|
        expect(page).to have_content comment.text
      end
    end

    it 'can see how many comments a post has' do
      user = User.first
      post = Post.first
      visit user_posts_path(user.id)
      expect(page).to have_content "Comments: #{post.comments_counter}"
    end
  end
end
