require 'rails_helper'

feature 'User can edit vote answer', %q{
  In order to give feedback
  As not the author of answer
  I'd like to be able to vote it
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Unauthenticated cannot vote question' do
    visit question_path(question)
    click_on 'vote-up-btn'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
