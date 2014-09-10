FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@test.com" }
    password 'password123456'
    password_confirmation 'password123456'
    sequence(:name) { |n| "example#{n}" }
  end
end
