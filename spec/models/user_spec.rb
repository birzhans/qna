require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }

  it { is_expected.to have_many(:answers).dependent(:destroy) }
  it { is_expected.to have_many(:questions).dependent(:destroy) }
  it { is_expected.to have_many(:rewards) }

  describe ".author_of?" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:question) { create(:question, user: user) }

    it "returns true for resource author" do
      expect(user).to be_author_of(question)
    end

    it "returns false for another user" do
      expect(another_user).not_to be_author_of(question)
    end
  end
end
