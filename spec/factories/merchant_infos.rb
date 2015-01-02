# Read about factories at https://github.com/thoughtbot/factory_girl
include Faker

FactoryGirl.define do
  factory :merchant_info do
    longitude Address.longitude
    latitude Address.latitude
    workday_opening_time "08:30 AM - 10:30 PM"
    sat_opening_time "08:30 AM - 10:30 PM"
    sun_opening_time "08:30 AM - 10:30 PM"
    url Internet.url
    orgnization Company.name
    sales_email Internet.email
    sales_phone PhoneNumber.phone_number
  end
end
