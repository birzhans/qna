FactoryBot.define do
  factory :vote do
    kind { 1 }
    votable { nil }
    user
  end
end
