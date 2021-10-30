FactoryBot.define do
  factory :comment do
    commentable { nil }
    user { nil }
    body { 'MyString' }
  end
end
