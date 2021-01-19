require 'rails_helper'

feature 'User can sign up', "
  In order to ask questions
  As any user
  I'd like to be able to sign up" do
  given(:user) { create(:user) }
  background { visit new_user_registration_path }

  scenario 'User tries to sign up with valid data' do
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'User tries to sign up with invalid data' do
    click_on 'Sign up'
    expect(page).to have_content '2 errors prohibited this user from being saved:'
  end

  scenario 'User tries to sign up with existing email' do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_on 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end
end