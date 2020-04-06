FactoryBot.define do
  factory :board do
    title { "MyString" }
    association :user
  end
end
