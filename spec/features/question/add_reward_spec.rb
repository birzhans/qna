require 'rails_helper'

feature 'User can add reward to question', "
  In order to give prize to an author of the best answer
  As an question's author
  I'd like to be able to add reward
" do
  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      login user
      visit new_question_path

      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'
    end

    scenario 'adds reward when creates question' do
      fill_in 'Reward name', with: 'reward_1'
      attach_file 'Reward image', "#{Rails.root}/app/assets/images/reward.jpg"

      click_on 'Ask'
      expect(page).to have_content 'reward_1'
    end
  end
end
