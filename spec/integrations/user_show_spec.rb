require 'rails_helper'
require './spec/integrations/integration_mocks'

RSpec.describe 'user index view', type: :feature do
  include Mocks
  before :each do
    @users = create_users
    posts = create_posts(@users)

    visit new_user_session_path

    within('form') do
      fill_in 'user_email', with: 'foo1@foo.com'
      fill_in 'user_password', with: 'admin123'
    end
    click_button 'Log in'
    click_on('Mateo')
  end

  context 'displaying user info' do
    it 'user image is displayed' do
      expect(page).to have_selector('img')
    end
    it 'user name is displayed' do
      expect(page).to have_content(@users[0].name)
    end
    it 'user number of post is displayed' do
      expect(page).to have_content "Number of posts: #{@users[0].posts_counter}"
    end
    it 'user profile is displayed' do
      expect(page).to have_current_path "/users/#{@users[0].id}"
    end

    it 'user bio is displayed' do
      expect(page).to have_content @users[0].bio
    end

    it 'user recent posts are displayed' do
      recent_posts = @users[0].recent_posts
      recent_posts.each do |post|
        expect(page).to have_content "Post ##{post.title}"
      end
    end

    it 'See all posts button is displayed' do
      expect(page).to have_content 'See all posts'
    end
  end
  context 'Redirecting properly to other paths' do
    it "When I click a user's post, it redirects me to that post's show page" do
      post = @users[0].recent_posts[0]
      click_link("Post ##{post.title}")
      expect(page).to have_current_path "/users/#{@users[0].id}/posts/#{post.id}"
    end

    it "When I click to see all posts, it redirects me to the user's post's index page" do
      click_link('See all posts')
      expect(page).to have_current_path '/users/'
    end
  end
end
