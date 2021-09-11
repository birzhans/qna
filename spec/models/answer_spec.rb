require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { is_expected.to belong_to :question }

  it { is_expected.to validate_presence_of :body }

  it 'has many attached files' do
    expect(Answer.new.files).to be_instance_of(ActiveStorage::Attached::Many)
  end
end
