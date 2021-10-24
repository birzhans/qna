require 'rails_helper'

feature 'User can edit question links', "
  As an question's author
  I'd like to be able to edit links
" do
  given(:user) { create(:user) }
  given(:google_url) { 'https://www.google.com/?client=safari' }
  given(:question) { create(:question, user: user) }

  describe 'Authenticated user' do
    background do
      login user
      visit question_path(question)
    end

    scenario 'User deletes link from question', js: true do
      click_on 'Edit'
      within '#edit-question-links' do
        click_on 'add link'
        fill_in 'Name', with: 'Link 1'
        fill_in 'Url', with: google_url
      end

      click_on 'Save'

      expect(page).to have_link 'Link 1'
    end
  end
end
