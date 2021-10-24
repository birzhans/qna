require 'rails_helper'

feature 'User can delete file from his own answer', "
As authenticated user
I'd like to be able to delete file from my answer
" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, :has_attached_file, user: user, question: question) }

  given(:another_user) { create(:user) }
  given(:another_question) { create(:question) }
  given(:another_answer) { create(:answer, :has_attached_file, user: another_user, question: another_question) }

  describe 'Authenticated user' do
    background do
      login user
    end

    scenario 'Deletes existing file', js: true do
      visit question_path(answer.question)
      within "#answer-#{answer.id}" do
        expect(page).to have_content 'Delete File'

        click_on 'Delete File'

        expect(page).not_to have_content 'Delete File'
      end
    end

    scenario "Try to delete not authoring question's existing file", js: true do
      visit question_path(another_answer.question)

      within "#answer-#{another_answer.id}" do
        expect(page).not_to have_content 'Delete File'
      end
    end
  end

  describe 'Unauthenticated user' do
    scenario "Tries to delete question's existing file", js: true do
      visit question_path(answer.question)
      within("#answer-#{answer.id}") do
        expect(page).not_to have_content 'Delete File'
      end
    end
  end
end
