require 'rails_helper'

feature 'User can create question', "
  In order to get answer from community
  As an authenticated user
  I'd like to be able to ask the question
" do
  given(:user) { create(:user) }

  describe 'Multiple session', js: true do
   scenario "question appears on another user's page" do
     using_session('user') do
       login(user)
       visit questions_path
       click_on 'Ask Question'
     end

     using_session('guest') do
       visit questions_path
     end

     using_session('user') do
       fill_in 'question_title', with: 'Title'
       fill_in 'question_body', with: 'Body'
       click_on 'Ask'
       save_and_open_page
       expect(page).to have_content 'Title'
     end

     using_session('guest') do
       save_and_open_page
       expect(page).to have_content 'Title'
     end
   end
  end

  describe 'Authenticated user' do
    background do
      login(user)
      visit questions_path
      click_on 'Ask Question'
    end

    scenario 'asks a question' do
      fill_in 'Title', with: 'Question title'
      fill_in 'Body', with: 'Question body'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'Question title'
      expect(page).to have_content 'Question body'
    end

    scenario 'asks a question with errors' do
      click_on 'Ask'
      expect(page).to have_content "Title can't be blank"
    end

    scenario 'asks a question with attached file' do
      fill_in 'Title', with: 'Question title'
      fill_in 'Body', with: 'Question body'
      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Ask'
      expect(page).to have_content 'rails_helper.rb'
      expect(page).to have_content 'spec_helper.rb'
    end
  end

  scenario 'Unauthenticated user tries to ask a question' do
    visit questions_path
    click_on 'Ask Question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
