require 'rails_helper'

feature 'User can vote answer', "
  In order to give feedback
  As not the author of answer
  I'd like to be able to vote it
" do
  given!(:user) { create(:user) }
  given!(:answer_author) { create(:user) }

  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: answer_author) }

  scenario 'Unauthenticated user cannot vote answer', js: true do
    visit question_path(question)
    within('.answers') do
      expect(page).not_to have_selector('#like', wait: 0.1)
      expect(page).not_to have_selector('#dislike', wait: 0.1)
    end
  end

  scenario 'Authenticated user votes answer', js: true do
    login(user)
    visit question_path(question)
    within "#answer-#{answer.id}" do
      click_on 'like'

      expect(page).to have_content(answer.vote_balance, wait: 0.1)
    end
  end

  scenario 'Authenticated user tries to vote own question', js: true do
    login(answer_author)
    visit question_path(question)

    within("#answer-#{answer.id}") do
      expect(page).not_to have_selector('#like', wait: 0.1)
      expect(page).not_to have_selector('#dislike', wait: 0.1)
    end
  end

  scenario 'Authenticated user tries to vote answer second time', js: true do
    login(user)
    Vote.create!(votable: answer, user: user, kind: 1)
    visit question_path(question)

    within("#answer-#{answer.id}") do
      click_on 'like'
      expect(page).to have_content('Already voted', wait: 0.1)
    end
  end

  scenario 'Authenticated user can cancel vote', js: true do
    login(user)
    Vote.create!(votable: answer, user: user, kind: 1)
    visit question_path(question)

    within("#answer-#{answer.id}") do
      click_on 'Cancel'
      click_on 'like'
      expect(page).not_to have_content('User Already voted', wait: 0.1)
    end
  end
end
