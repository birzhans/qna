# require 'rails_helper'
#
# RSpec.describe VotesController, type: :controller do
#   describe 'POST #create' do
#     let(:user) { create(:user) }
#     before { login(user) }
#
#     context "with valid attributes" do
#       it 'saves a new question to a database' do
#         expect { post :create, params: { vote: attributes_for(:vote) } }.to change(Vote, :count).by(1)
#       end
#
#       it 'renders vote json' do
#         post :create, params: { vote: attributes_for(:vote) }
#         expect(response.content_type).to include('application/json')
#         # JSON.parse(response.body)
#       end
#     end
#
#     context "with invalid attributes" do
#     end
#   end
#
#
#   describe 'DELETE #desrtoy' do
#     let(:user) { create(:user) }
#     before { login(user) }
#   end
# end
