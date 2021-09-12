require 'rails_helper'

feature 'user can create answer', %q{
  In order to answer to the question
  As an authenticated user
  I'd like to be able to answer on question's page
} do
  given(:question) { create :question }

  describe 'Authenticated user' do
    given(:user) { create(:user) }

    background do
      login(user)
      visit question_path(question)
    end

    scenario 'creates valid answer', js: true do
      fill_in 'new-answer-body', with: 'Answer body'
      click_on 'Create'

      expect(page).to have_content('Your answer Answer body successfully created.', wait: 0.1)
      within '.answers' do
        expect(page).to have_content('Answer body', wait: 0.1)
      end
    end

    scenario 'creates invalid answer', js: true do
      click_on 'Create'
      expect(page).to have_content("Body can't be blank", wait: 0.1)
    end

    scenario 'creates answer with attached file', js: true do
      fill_in 'new-answer-body', with: 'Answer body'

      attach_file 'new-answer-files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Create'

      expect(page).to have_content 'rails_helper.rb'
      expect(page).to have_content 'spec_helper.rb'
    end
  end

  scenario 'Unauthenticated user creates question' do
    visit question_path(question)
    click_on 'Create'
    expect(page).to have_content('You need to sign in or sign up before continuing.', wait: 0.1)
  end
end
