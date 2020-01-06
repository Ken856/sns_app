FactoryBot.define do
  factory :post do
    user_id { 1 }
    board_id { 1 }
    body { "MyString" }
  end
end
