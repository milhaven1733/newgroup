FactoryGirl.define do
  factory :adress do
    first { Faker::Address.street_address }
    second { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zipcode { Faker::Address.zip }
  end
end
