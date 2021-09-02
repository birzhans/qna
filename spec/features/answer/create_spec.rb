require 'rails_helper'

feature 'user can create answer', "
  In order to answer to the question
  As an authenticated user
  I'd like to be able to answer on question's page" do
  given(:question) { create :question }

  describe 'Authenticated user' do
    given(:user) { create(:user) }

    background do
      login(user)
      visit question_path(question)
    end

    scenario 'creates valid question', js: true do
      fill_in 'answer_body', with: 'Answer body'
      click_on 'Post'

      expect(page).to have_content('Your answer Answer body successfully created.', wait: 0.1)
      within '.answers' do
        expect(page).to have_content('Answer body', wait: 0.1)
      end
    end

    scenario 'creates invalid question', js: true do
      click_on 'Post'
      expect(page).to have_content("Body can't be blank", wait: 0.1)
    end
  end

  scenario 'Unauthenticated user creates question' do
    visit question_path(question)
    click_on 'Post'
    expect(page).to have_content('You need to sign in or sign up before continuing.', wait: 0.1)
  end
end
