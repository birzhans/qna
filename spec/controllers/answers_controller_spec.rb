require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe 'POST #create' do
    before { login(user) }
    context 'with valid attributes' do
      it 'saves a new answer to a database' do
        expect do
          post :create,
               params: { answer: attributes_for(:answer), question_id: question },
               format: :js
        end.to change(question.answers, :count).by(1)
      end

      it 'renders create template' do
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

  describe 'PATCH #update' do
    let!(:answer) { create(:answer, question: question, user: user) }
    context "author" do
      before { login user }

      context 'with valid attributes' do
        it 'changes answer attributes' do
          patch :update, params: { id: answer.id, answer: { body: 'edited body' } }, format: :js
          answer.reload
          expect(answer.body).to eq 'edited body'
        end

        it 'renders update template' do
          patch :update, params: { id: answer.id, answer: { body: 'edited body' } }, format: :js
          expect(response).to render_template :update
        end
      end

      context 'with invalid attributes' do
        it 'does not change answer attributes' do
          expect do
            patch :update, params: { id: answer.id, answer: attributes_for(:answer, :invalid) }, format: :js
          end.to_not change(answer, :body)
        end

        it 'renders update template' do
          patch :update, params: { id: answer.id, answer: attributes_for(:answer, :invalid) }, format: :js
          expect(response).to render_template :update
        end
      end
    end

    context "not author" do
      before { login another_user }

      it 'does not change answer attributes' do
        expect do
          patch :update, params: { id: answer.id, answer: { body: 'edited body' } }, format: :js
        end.to_not change(answer, :body)
      end
    end
  end

  describe "DELETE #destroy" do
    context "author" do
      before { login user }
      let!(:answer) { create(:answer, question: question, user: user) }

      it 'deletes the answer' do
        expect do
          delete :destroy, params: { id: answer.id }, format: :js
        end.to change(Answer, :count).by(-1)
      end
    end

    context "not author" do
      before { login another_user }
      let!(:answer) { create(:answer, question: question, user: user) }

      it 'does not delete the answer' do
        expect do
          delete :destroy, params: { id: answer.id }, format: :js
        end.not_to change(Answer, :count)
      end
    end
  end
end
