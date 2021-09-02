require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  before { login(user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new answer to a database' do
        expect do
          post :create,
               params: { answer: attributes_for(:answer), question_id: question },
               format: :js
        end.to change(question.answers, :count).by(1)
      end

      it 'renders create view' do
        post :create,
             params: { answer: attributes_for(:answer), question_id: question },
             format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect do
          post :create,
               params: { question_id: question, answer: attributes_for(:answer, :invalid) },
               format: :js
        end.not_to change(question.answers, :count)
      end

      it 'renders question view' do
        post :create,
             params: { question_id: question, answer: attributes_for(:answer, :invalid) },
             format: :js
        expect(response).to render_template :create
      end
    end
  end
end
