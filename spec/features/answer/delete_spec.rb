require 'rails_helper'

feature 'User can delete answer', "
As an authenticated user
I'd like to be able to delete my answer
" do
  given!(:user) { create(:user) }
  given!(:other) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Authenticated user tries to delete own answer', js: true do
    login(user)
    visit question_path(question)
    click_on 'Delete Answer'
    expect(page).to have_content 'Answer was successfully deleted.'
  end

  scenario "Authenticated user tries to delete other's answer", js: true do
    login(other)
    visit question_path(question)
    expect(page).not_to have_content 'Delete Answer'
  end

  scenario 'Unauthenticated user tries to delete answer', js: true do
    visit question_path(question)
    within '.answers' do
      expect(page).not_to have_content 'Delete Answer'
    end
  end
end
