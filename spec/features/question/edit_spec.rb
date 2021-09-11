require 'rails_helper'

feature "User can edit own questions", %q{
As authenticated user
I'd like to be able to edit own questions
} do
  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:other_question) { create(:question, user: other_user) }

  describe 'Authenticated user' do
    background do
      login(user)
    end

    scenario 'Edits his question', js: true do
      visit question_path(question)
      click_on 'Edit'
      fill_in 'question_body', with: 'Edited question'
      click_on 'Save'
      expect(page).to_not have_content(question.body, wait: 0.1)
      expect(page).to have_content('Edited question', wait: 0.1)
      within '#question-body' do
        expect(page).to_not have_selector('textarea', wait: 0.1)
      end
    end

    scenario 'Adds files to question', js: true do
      visit question_path(question)
      click_on 'Edit'
      fill_in 'question_body', with: 'Edited question'

      within "#edit-question-#{question.id}" do
        attach_file 'File', "#{Rails.root}/package.json"
        click_on 'Save'
      end

      expect(page).to have_content('package.json', wait: 0.1)
    end

    scenario 'Edits his question with errors', js: true do
      visit question_path(question)
      click_on 'Edit'
      fill_in 'question_body', with: ''
      click_on 'Save'

      expect(page).to have_content("Body can't be blank", wait: 0.1)
    end

    scenario "Tries to edit someone's question", js: true do
      visit question_path(other_question)
      expect(page).not_to have_content('Edit', wait: 0.1)
    end
  end

  scenario "Unauthenticated user can't edit question" do
    visit question_path(question)
    expect(page).not_to have_content('Edit')
  end
end
