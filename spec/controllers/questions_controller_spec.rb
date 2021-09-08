require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { login user }

    before { get :new }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login user }

    context 'with valid attributes' do
      it 'saves a new question to a database' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect do
          post :create, params: { question: attributes_for(:question, :invalid) }
        end.not_to change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:question, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do

    context 'author with valid attributes' do
      before { login question.user }
      it 'assigns a new Question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question) }, format: :js
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' } }, format: :js
        question.reload

        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to updated question' do
        patch :update, params: { id: question, question: attributes_for(:question) }, format: :js
        expect(response).to redirect_to question
      end
    end

    context 'author with invalid attributes' do
      before do
        patch :update, params: { id: question, question: attributes_for(:question, :invalid) }, format: :js
        login question.user
      end

      it 'does not change question' do
        question.reload
        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyText'
      end
    end

    context "not author" do
      before do
        login user
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }  }, format: :js
      end

      it 'does not change question' do
        question.reload
        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyText'
      end
    end
  end

  describe 'DELETE #destroy' do
    context "author" do
      before { login question.user }

      it 'deletes the question' do
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end

      it 'redirects to index view' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end

    context "not author" do
      before do
        login user
        delete :destroy, params: { id: question }
      end

      it 'does not delete the question' do
        expect { delete :destroy, params: { id: question } }.not_to change(Question, :count)
      end
    end
  end

  describe "POST #best_answer" do
    context "author" do
      before { login question.user }

      context "Question doesn't have the best answer" do
        let(:answer) { create(:answer, question: question, user: question.user) }
        before { post :best_answer, params: { id: question.id, answer_id: answer.id }, format: :js }

        it 'saves the best answer to question' do
          question.reload
          expect(question.best_answer_id).to eq answer.id
        end
      end

      context "Question has the best answer" do
        let(:answer) { create(:answer, question: question, user: question.user) }
        let(:other_answer) { create(:answer, question: question, user: user) }
        before do
          question.update(best_answer: answer)
          post :best_answer, params: { id: question.id, answer_id: other_answer.id }, format: :js
        end

        it 'saves the best answer to question' do
          question.reload
          expect(question.best_answer_id).to eq other_answer.id
        end
      end
    end

    context "not author" do
      before { login user }
      let(:answer) { create(:answer, question: question, user: question.user) }
      before { post :best_answer, params: { id: question.id, answer_id: answer.id }, format: :js }

      it 'does not save the best answer to question' do
        question.reload
        expect(question.best_answer_id).to eq nil
      end
    end
  end
end
