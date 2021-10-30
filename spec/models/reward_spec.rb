require 'rails_helper'

RSpec.describe Reward, type: :model do
  it { is_expected.to belong_to :question }
  it { is_expected.to belong_to(:user).optional }

  it { is_expected.to validate_presence_of :name }

  it 'has one attached file' do
    expect(described_class.new.image).to be_instance_of(ActiveStorage::Attached::One)
  end
end
