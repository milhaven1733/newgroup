# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :merchant_info do
    user_id 1
    longitude 1.5
    latitude 1.5
    opening_time "2014-11-09 08:43:51"
    closing_time "2014-11-09 08:43:51"
    url "MyString"
  end
end
