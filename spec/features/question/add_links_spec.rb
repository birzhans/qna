require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do
  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/vkurennov/743f9367caa1039874af5a2244e1b44c' }

  describe 'Authenticated user' do
    background do
      login user
      visit new_question_path

      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'
    end

    scenario 'User adds link when asks question' do
      within('#new-links') do
        fill_in 'Name', with: 'Link 1'
        fill_in 'Url', with: gist_url
      end

      click_on 'Ask'
      expect(page).to have_link 'Link 1', href: gist_url
    end

    scenario 'User adds invalid link when asks question' do
      within('#new-links') do
        fill_in 'Name', with: 'Link 1'
        fill_in 'Url', with: 'invalid link'
      end

      click_on 'Ask'
      expect(page).to have_content 'Links url is invalid'
    end
  end
end
