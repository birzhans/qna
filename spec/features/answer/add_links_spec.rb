require 'rails_helper'

feature 'User can add links to answer', "
  In order to provide additional info to my answer
  As an question's author
  I'd like to be able to add links
" do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given(:google_url) { 'https://www.google.com/?client=safari' }

  scenario 'User adds link when give an answer', js: true do
    login user

    visit question_path(question)

    fill_in 'new-answer-body', with: 'My answer'

    fill_in 'Name', with: 'My gist'
    fill_in 'Url', with: google_url

    click_on 'Create'

    within '.answers' do
      expect(page).to have_link 'My gist', href: google_url
    end
  end
end
