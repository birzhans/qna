FactoryBot.define do
  factory :vote do
    votable { nil }
    user { nil }
    kind { 1 }
  end
end
