# Read about factories at https://github.com/thoughtbot/factory_girl
include Faker

FactoryGirl.define do
  factory :user_info do
    phone PhoneNumber.phone_number
    is_student false
    group_name Company.name
    number_of_group_members 1
    university "MyString"
    wallet_link Internet.url

    factory :student_info do
      is_student true
    end
  end
end
