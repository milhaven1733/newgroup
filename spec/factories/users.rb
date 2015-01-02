FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@test.com" }
    password 'password123456'
    password_confirmation 'password123456'
    sequence(:name) { |n| "example#{n}" }

    factory :normal do
      role 'normal'
      after(:create) do |user|
        user.user_info = build(:user_info)
        user.user_info.address = build(:adress)
        user.save
      end
    end

    factory :student do
      sequence(:email) { |n| "example#{n}@test.edu" }
      role 'normal'
      after(:create) do |user|
        user.user_info = build(:student_info)
        user.save
      end
    end

    factory :merchant do
      role 'merchant'
      after(:create) do |user|
        user.merchant_info = build(:merchant_info)
        user.merchant_info.address = build(:adress)
        user.save
      end
    end
  end
end