# Read about factories at https://github.com/thoughtbot/factory_girl
include Faker

FactoryGirl.define do
  factory :user_info do
    user_id 1
    phone PhoneNumber.phone_number
    address Address.street_address
    is_student false
    zipcode Address.zip_code
    group_name Company.name
    number_of_group_members 1
    university "MyString"
    billing_address Address.street_address
    wallet_link Internet.url
  end
end
