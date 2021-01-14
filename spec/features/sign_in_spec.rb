require 'rails_helper'

feature 'user can log in',  %q{
  In order to ask questions
  As an authenticated user
  I'd like to be able to sign in
} do
  scenario 'Registered user tries to sign in' do
    User.create!(email: 'example@mail.com', password: 'secret')

    visit '/login'
    fill_in 'Email', with: 'example@mail.com'
    fill_in 'Password', with: 'secret'

    expect(page).to have_content 'Signed in successfully.'
  end


  scenario 'Unregistered user tries to sign in'
end