FactoryBot.define do
  factory :post do
    body { "MyString" }
    association :user
    association :board
  end
end
