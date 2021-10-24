require 'rails_helper'

feature 'User can see awarded rewards', "
  As an authenticated user
  I'd like to be able to see list of rewards
" do
  given(:user) { create(:user) }

  scenario 'Authenticated user', js: true do
    login user
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Reward name', with: 'reward_1'
    attach_file 'Reward image', "#{Rails.root}/app/assets/images/reward.jpg"
    click_on 'Ask'

    visit question_path(Question.last)
    fill_in 'new-answer-body', with: 'Answer body'
    click_on 'Create'

    visit question_path(Question.last)
    click_on 'Mark Best'

    visit rewards_path
    expect(page).to have_content 'reward_1'
  end

  scenario 'Unauthenticated user' do
    visit rewards_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
