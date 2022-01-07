require 'rails_helper'
require './spec/integrations/integration_mocks'

RSpec.describe 'user index view', type: :feature do
  include Mocks
  before :each do
    users = create_users
    visit new_user_session_path

    within('form') do
      fill_in 'user_email', with: 'foo1@foo.com'
      fill_in 'user_password', with: 'admin123'
    end
    click_button 'Log in'
  end
  context 'displaying correctly' do
    it 'all users name' do
      users = User.all

      users.each do |user|
        expect(page).to have_content user.name
      end
    end
    it 'all users images' do
      users = User.all.order(:id)
      imgs = page.all('img')

      users.each_with_index do |user, index|
        expect(imgs[index]['src']).to include(user.name)
      end
      expect(imgs.length).to be(users.length)
    end

    it 'all users post counters' do
      users = User.all
      users.each do |user|
        expect(page).to have_content "Number of posts: #{user.posts_counter}"
      end
    end
  end
end
