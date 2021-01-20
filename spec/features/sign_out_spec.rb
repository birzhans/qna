require 'rails_helper'

feature 'User can sign out', "
  In order to sign out
  As an authenticated user
  I'd like to be able to destroy session" do
  given(:user) { create(:user) }

  scenario 'Authenticated user tries to sign out' do
    login(user)
    visit root_path
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'Unauthenticated user tries to sign out' do
    visit root_path
    expect(page).to have_no_content 'Sign out'
  end
end
