require 'rails_helper'

feature 'User can edit question links', %q{
  As an question's author
  I'd like to be able to edit links
} do
  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/vkurennov/743f9367caa1039874af5a2244e1b44c' }
  given(:question) { create(:question, user: user) }

  given(:another_user) { create(:user) }
  given(:another_question) { create(:question, user: another_user, links: [Link.new(name: 'link1', url: gist_url)] ) }
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
        fill_in 'Url', with: gist_url
      end

      click_on 'Save'

      expect(page).to have_link 'Link 1'
    end
  end
end
