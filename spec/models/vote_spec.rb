require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to :votable }
  it { should belong_to :user }

  it { should validate_presence_of :kind }

  describe ".votable_balance" do
    let(:user) { create(:user) }
    let(:question) { create(:question) }
    let(:vote) { create(:vote, votable: question, user: user) }

    it "returns votable vote balance" do
      expect(vote.votable_balance).to eq vote.votable.vote_balance
    end
  end
end
