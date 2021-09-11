require 'rails_helper'

feature 'User can edit his answer', %q{
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  given!(:other_user) { create(:user) }
  given!(:other_question) { create(:question) }
  given!(:other_answer) { create(:answer, question: other_question, user: other_user) }

  scenario 'Unauthenticated cannot edit answer' do
    visit question_path(question)
    expect(page).to_not have_link('Edit')
  end

  describe 'Authenticated user' do

    background { login(user) }

    scenario 'edits his answer', js: true do
      visit question_path(question)
      click_on 'Edit'
      within '.answers' do
        fill_in 'answer_body', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content('edited answer', wait: 0.1)
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'Adds files to answer', js: true do
      visit question_path(question)
      click_on 'Edit'

      within '.answers' do
        fill_in 'answer_body', with: 'edited answer'
        attach_file 'File', "#{Rails.root}/package.json"
        click_on 'Save'
        expect(page).to have_content('package.json', wait: 0.1)
      end
    end

    scenario 'edits his answer with errors', js: true do
      visit question_path(question)
      click_on 'Edit'
      within '.answers' do
        fill_in 'answer_body', with: ''
        click_on 'Save'
      end
      expect(page).to have_content("Body can't be blank", wait: 0.1)
    end

    scenario "tries to edit other's answer", js: true do
      visit question_path(other_question)
      expect(page).to_not have_content 'Edit'
    end
  end
end
