require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }

  describe ".author_of?" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:question) { create(:question, user: user) }

    it "returns true for resource author" do
      expect(user.author_of?(question)).to eq true
    end

    it "returns false for another user" do
      expect(another_user.author_of?(question)).to eq false
    end
  end
end
