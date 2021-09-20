require 'rails_helper'

feature 'User can delete links from question', %q{
  As an question's author
  I'd like to be able to delete links
} do
  given(:user) { create(:user) }
  given(:google_url) { 'https://www.google.com/?client=safari' }
  given(:question) { create(:question, user: user, links: [Link.new(name: 'link1', url: google_url)]) }

  given(:another_user) { create(:user) }
  given(:another_question) { create(:question, user: another_user, links: [Link.new(name: 'link1', url: google_url)] ) }
  describe 'Authenticated user' do
    background do
      login user
      visit question_path(question)
    end

    scenario 'User deletes link from question', js: true do
      within '#question-links' do
        click_on 'Delete'
      end

      expect(page).not_to have_link 'link1'
    end

    scenario 'User tries to delete link from another question' do
    end
  end
end
