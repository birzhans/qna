require 'rails_helper'

feature 'user can create answer', "
  In order to answer to the question
  As an authenticated user
  I'd like to be able to answer on question's page" do
  given(:question) { create :question }

  describe 'Authenticated user' do
    given(:user) { create(:user) }

    background { login(user) }

    background { visit question_path(question) }

    scenario 'creates valid question' do
      fill_in 'Body', with: 'Answer body'
      click_on 'Answer'

      expect(page).to have_content 'Your answer successfully created.'
      expect(page).to have_content 'Answer body'

    end

    scenario 'creates invalid question' do
      click_on 'Answer'
      expect(page).to have_content "Body can't be blank."
    end
  end

  scenario 'Unauthenticated user creates question' do
    visit question_path(question)
    click_on 'Answer'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end