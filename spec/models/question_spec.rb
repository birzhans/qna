require 'rails_helper'

RSpec.describe Question, type: :model do
  it { is_expected.to have_many(:answers).dependent(:destroy) }
  it { is_expected.to have_many(:links).dependent(:destroy) }
  it { is_expected.to have_one(:reward).dependent(:destroy) }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }

  it { should accept_nested_attributes_for :links }
  it { should accept_nested_attributes_for :reward }

  it 'has many attached files' do
    expect(Question.new.files).to be_instance_of(ActiveStorage::Attached::Many)
  end
end
