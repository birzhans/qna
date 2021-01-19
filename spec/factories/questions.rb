FactoryBot.define do
  factory :question do
    title { 'MyString' }
    body { 'MyText' }
    user
  end

  trait :invalid do
    title { nil }
  end
end
