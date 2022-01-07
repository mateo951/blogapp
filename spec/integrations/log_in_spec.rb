require 'rails_helper'

describe 'the login process', type: :feature do
  before :each do
    user = User.new(name: 'Mateo', bio: "I'm a testing living creature", posts_counter: 0,
                    email: 'mateovillagomez1995@gmail.com')
    user.password = '123456'
    user.password_confirmation = '123456'
    user.save
  end

  context 'Elements on page dispaly' do
    it 'Login form shows elements correct' do
      visit '/users/sign_in'
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
      expect(page).to have_content('Log in')
    end
  end
  context 'User interaction on log in form' do
    it 'Receive error if log in fields are left blank' do
      visit '/users/sign_in'
      click_button('Log in')
      expect(page).to have_content 'Invalid Email or password.'
    end
    it 'Receive error if data is incorrect' do
      visit '/users/sign_in'
      within('form') do
        fill_in 'user_email', with: 'test@gmail.com'
        fill_in 'user_password', with: '1234345345'
      end
      click_button('Log in')
      expect(page).to have_content 'Invalid Email or password.'
    end
    it 'Redirect if data is correct' do
      visit new_user_session_path
      within('form') do
        fill_in 'user_email', with: 'mateovillagomez1995@gmail.com'
        fill_in 'user_password', with: '123456'
      end
      click_button('Log in')
      expect(current_path).to eq(root_path)
    end
  end
end
