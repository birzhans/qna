require 'rails_helper'

feature 'User can edit vote answer', "
  In order to give feedback
  As not the author of answer
  I'd like to be able to vote it
" do
  given!(:user) { create(:user) }
  given!(:question_author) { create(:user) }
  given!(:question) { create(:question, user: question_author) }

  scenario 'Unauthenticated user cannot vote question', js: true do
    visit question_path(question)
    expect(page).not_to have_selector('#like', wait: 0.1)
    expect(page).not_to have_selector('#dislike', wait: 0.1)
  end

  scenario 'Authenticated user votes question', js: true do
    login(user)
    visit question_path(question)

    click_on 'like'

    within '.votes' do
      expect(page).to have_content(question.vote_balance, wait: 0.1)
    end
  end

  scenario 'Authenticated user tries to vote own question' do
    login(question_author)
    visit question_path(question)

    expect(page).not_to have_selector('#like', wait: 0.1)
    expect(page).not_to have_selector('#dislike', wait: 0.1)
  end

  scenario 'Authenticated user tries to vote question second time', js: true do
    login(user)
    Vote.create!(votable: question, user: user, kind: 1)
    visit question_path(question)
    click_on 'like'

    expect(page).to have_content('Already voted', wait: 0.1)
  end

  scenario 'Authenticated user can cancel vote', js: true do
    login(user)
    Vote.create!(votable: question, user: user, kind: 1)
    visit question_path(question)
    click_on 'Cancel'
    click_on 'like'
    expect(page).not_to have_content('User Already voted', wait: 0.1)
  end
end
