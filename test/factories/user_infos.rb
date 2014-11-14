# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_info do
    phone "MyString"
    address "MyString"
    is_student false
    zipcode "MyString"
    group_name "MyString"
    number_of_group_members 1
    university "MyString"
    billing_address "MyString"
    wallet_link "MyString"
  end
end
