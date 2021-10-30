require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'saves a new comment' do
        expect do
          post :create,
               params: { comment: {
                 user_id: user.id,
                 body: 'body',
                 commentable_type: 'Question',
                 commentable_id: question.id
               } },
               format: :js
        end.to change(Comment, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save a new comment' do
        expect do
          post :create,
               params: {
                 comment: {
                   user_id: user.id,
                   commentable_type: 'Question',
                   commentable_id: question.id
                 }
               },
               format: :js
        end.not_to change(Comment, :count)
      end
    end
  end
end
