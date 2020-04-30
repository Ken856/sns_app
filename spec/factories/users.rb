FactoryBot.define do
  factory :user do
    name {"Aaron"}
    sequence(:email) {|n| "test#{n}@example.com"}
    password {"hogehoge"}
    password_confirmation {"hogehoge"}
    introduction {"foobar"}
  end
  
  factory :other_user, class: User do
    name {"Alice"}
    sequence(:email) {|n| "alice@example.com"}
    password {"hogehoge"}
    password_confirmation {"hogehoge"}
    introduction {"こんにちは"}
  end
end
