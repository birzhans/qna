require 'rails_helper'

feature 'Question author can choose best question', %q{
  As an authenticated user and author of question
  I'd like to be able to pick the best answer
} do
  given!(:user) { create(:user) }
  given!(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:another_question) { create(:question, user: another_user) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given!(:another_answer) { create(:answer, question: another_question, user: another_user) }

  scenario 'Authenticated user chooses the best answer', js: true do
    login(user)
    visit question_path(question)
    within "#answer-#{answer.id}" do
      click_on 'Mark Best'
    end
    within '#best-answer' do expect(page).to have_content(answer.body, wait: 0.1) end
    within '.answers' do expect(page).not_to have_content(answer.body, wait: 0.1) end

  end

  scenario 'Authenticated user changes the best answer', js: true do
    another_answer = create(:answer, question: question, user: user)
    question.update(best_answer: answer)
    login(user)
    visit question_path(question)
    within "#answer-#{another_answer.id}" do click_on 'Mark Best' end

    within '#best-answer' do expect(page).to have_content(another_answer.body, wait: 0.1) end
    within '.answers' do expect(page).to have_content(answer.body, wait: 0.1) end
  end

  scenario 'Authenticated user tries to choose the best answer for question without authorship', js: true do
    login(user)
    visit question_path(another_question)
    expect(page).not_to have_content('Mark Best')

  end
end
