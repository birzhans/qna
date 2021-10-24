FactoryBot.define do
  factory :answer do
    body { 'MyText' }

    trait :invalid do
      body { nil }
    end

    trait :has_attached_file do
      after :create do |answer|
        answer.files.attach(
          io: File.open(Rails.root.join('package.json')),
          filename: 'package.json',
          content_type: 'text/json'
        )
      end
    end
  end
end
