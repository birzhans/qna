# require 'rails_helper'
#
# RSpec.describe VotesController, type: :controller do
#   describe 'POST #create' do
#     let(:user) { create(:user) }
#     let(:question) { create(:question) }
#     before { login(user) }
#
#     context "with valid attributes" do
#       it 'saves a new vote to a database' do
#         expect {
#           post :create,
#           params: { votable_id: question.id, votable_type: 'Question', user_id: user.id, kind: 1 }
#         }.to change(Vote, :count).by(1)
#       end
#
#       it 'renders vote json' do
#         post :create, params: { votable_id: question.id, votable_type: 'Question', user_id: user.id, kind: 1 }
#         expect(response.content_type).to include('application/json')
#       end
#     end
#
#     context "with invalid attributes" do
#       it 'does not save a new vote to a database' do
#         expect { post :create, params: attributes_for(:vote) }.not_to change(Vote, :count)
#       end
#
#       it 'renders vote json' do
#         post :create, params: attributes_for(:vote)
#         expect(response.content_type).to include('application/json')
#       end
#     end
#   end
#
#
#   describe 'DELETE #desrtoy' do
#     let(:user) { create(:user) }
#     let(:question) { create(:question) }
#     let!(:vote) { create(:vote, votable: question, user: user) }
#
#     before { login user }
#
#     it 'deletes the answer' do
#       expect do
#         delete :destroy, params: { id: vote.id }, format: :js
#       end.to change(Vote, :count).by(-1)
#     end
#
#     it 'renders destroy template' do
#       delete :destroy, params: { id: vote.id }, format: :js
#       expect(response.content_type).to include('application/json')
#     end
#   end
# end
