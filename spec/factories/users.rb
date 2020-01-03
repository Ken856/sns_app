FactoryBot.define do
  factory :user do
    name {"Aaron"}
    sequence(:email) {|n| "test#{n}@test.com"}
    password {"hogehoge"}
    password_confirmation {"hogehoge"}
  end
end
