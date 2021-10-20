require 'rails_helper'

feature 'User can edit vote answer', %q{
  In order to give feedback
  As not the author of answer
  I'd like to be able to vote it
} do

  given!(:user) { create(:user) }
  given!(:question_author) { create(:user) }
  given!(:question) { create(:question, user: question_author) }

  scenario 'Unauthenticated user cannot vote question' do
    visit question_path(question)
    click_on 'vote-up-btn'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Authenticated user votes question' do
    login(user)
    visit question_path(question)

    click_on 'vote-up-btn'

    within '#vote' do
      expect(page).to have_content 1
    end
  end
end
