require 'rails_helper'

feature 'User can add links to question', "
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
" do
  given(:user) { create(:user) }
  given(:google_url) { 'https://www.google.com/?client=safari' }
  given(:gist_url) { 'https://gist.github.com/vkurennov/743f9367caa1039874af5a2244e1b44c' }

  describe 'Authenticated user' do
    background do
      login user
      visit new_question_path

      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'
    end

    scenario 'User adds link when asks question', js: true do
      within('#new-links') do
        fill_in 'Name', with: 'Link 1'
        fill_in 'Url', with: google_url
      end

      click_on 'Ask'
      expect(page).to have_link('Link 1', href: google_url, wait: 0.1)
    end

    scenario 'User adds gist link', js: true do
      within('#new-links') do
        fill_in 'Name', with: 'Link 1'
        fill_in 'Url', with: gist_url
      end

      click_on 'Ask'
      expect(page).to have_css('.gist', wait: 0.1)
    end

    scenario 'User adds invalid link when asks question', js: true do
      within('#new-links') do
        fill_in 'Name', with: 'Link 1'
        fill_in 'Url', with: 'invalid link'
      end

      click_on 'Ask'
      expect(page).to have_content('Links url is invalid', wait: 0.1)
    end
  end
end
