require 'rails_helper'

describe 'User can see all questions', "
  In order to find answer
  As any user
  I'd like to be able to see all questions
" do
  scenario 'User tries to visit questions index page' do
    visit questions_path
    expect(page).to have_content "All Questions (#{Question.count}):"
  end
end
