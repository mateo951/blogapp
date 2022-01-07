require 'rails_helper'
require './spec/integrations/integration_mocks'

RSpec.describe 'user index view', type: :feature do
  include Mocks  
  before :each do
    @user = User.new(name: 'Mateo V', bio: "I'm a testing living creature", posts_counter: 0, email: 'mateovillagomez1995@gmail.com')
    @user.password = '123456'
    @user.password_confirmation = '123456'
    @user.save
    visit new_user_session_path

    within('form') do
      fill_in 'user_email', with: 'mateovillagomez1995@gmail.com'
      fill_in 'user_password', with: '123456'
    end
    click_button 'Log in'
    click_on('Mateo V')
  end

  context 'displaying user info' do
    it 'user image is displayed' do
      expect(page).to have_selector('img')
    end
    it 'user name is displayed' do
      expect(page).to have_content(@user.name)
    end
    it 'user number of post is displayed' do 
      expect(page).to have_content "Number of posts: #{@user.posts_counter}"
    end
    it 'user profile is displayed' do 
      expect(page).to have_current_path "/users/#{@user.id}"
    end

    it 'user bio is displayed' do 
      expect(page).to have_content @user.bio
    end

    it 'user recent posts are displayed' do 
      recent_posts = @user.recent_posts
      recent_posts.each do |post|
        expect(page).to have_content "#{post.title} - ##{post.id}"
      end
    end

    it 'See all posts button is displayed' do
      expect(page).to have_content 'See all posts'
    end
  end
end