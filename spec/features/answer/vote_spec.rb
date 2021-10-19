# require 'rails_helper'
#
# feature 'User can edit vote answer', %q{
#   In order to give feedback
#   As not the author of answer
#   I'd like to be able to vote it
# } do
#
#   given!(:user) { create(:user) }
#   given!(:question) { create(:question) }
#   given!(:answer) { create(:answer, question: question, user: user) }
#
#   scenario 'Unauthenticated cannot vote answer' do
#     visit answer_path(answer)
#     expect(page).to_not have_link('Edit')
#   end
# end
