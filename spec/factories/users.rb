FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@test.com" }
    password 'password123456'
    password_confirmation 'password123456'
    sequence(:name) { |n| "example#{n}" }

    factory :student do
      sequence(:email) { |n| "example#{n}@test.edu" }
      user_info { FactoryGirl.create(:student_info) }
    end

    factory :merchant do
      role 'merchant'
    end
  end
end