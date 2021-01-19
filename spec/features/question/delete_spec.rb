require 'rails_helper'

feature 'User can delete own questions', "
As authenticated user
I'd like to be able to delete my questions" do
  given(:user) { create(:user) }
  given(:other) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario "Authenticated user tries to delete it's own question" do
    login(user)
    visit question_path(question)
    click_on 'Delete'
    expect(page).to have_content 'Question was successfully deleted.'
  end

  scenario "Authenticated user tries to delete someone's question" do
    login(other)
    visit question_path(question)
    expect(page).not_to have_content 'Delete'
  end

  scenario 'Unauthenticated user tries to delete question' do
    visit question_path(question)
    expect(page).not_to have_content 'Delete'
  end
end
