FactoryBot.define do
  factory :question do
    title { 'MyString' }
    body { 'MyText' }
    user
  end

  trait :invalid do
    title { nil }
  end

  trait :has_attached_file do
    after :create do |question|
        question.files.attach(
          io:           File.open(Rails.root.join('package.json')),
          filename:     'package.json',
          content_type: 'text/json'
        )
      end
  end
end
