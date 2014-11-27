FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@test.com" }
    password 'password123456'
    password_confirmation 'password123456'
    sequence(:name) { |n| "example#{n}" }

    trait :student do
      sequence(:email) { |n| "example#{n}@test.edu" }
      is_student true
    end
  end
end