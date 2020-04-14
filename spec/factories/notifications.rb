FactoryBot.define do
  factory :notification do
    user_id { "" }
    friend_id { "" }
    action { "MyString" }
  end
end
