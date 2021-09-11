require 'rails_helper'

feature "User can delete file from his own question", %q{
As authenticated user
I'd like to be able to delete file from my question
} do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question, :has_attached_file, user: user) }
  given(:another_question) { create(:question, :has_attached_file, user: another_user) }

  describe "Authenticated user" do
    background { login user }

    scenario 'Deletes existing file', js: true do
      visit question_path(question)
      within('#question-files') do
        expect(page).to have_content 'Delete'

        click_on 'Delete'
        expect(page).not_to have_content question.files.first.filename.to_s
      end
    end

    scenario "Try to delete not authoring question's existing file", js: true do
      visit question_path(another_question)
      within('#question-files') do
        expect(page).not_to have_content 'Delete'
      end
    end
  end

  describe "Unauthenticated user" do
    scenario "Tries to delete question's existing file", js: true do
      visit question_path(question)
      within('#question-files') do
        expect(page).not_to have_content 'Delete'
      end
    end
  end
end
