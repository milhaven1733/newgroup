# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    user_id 1
    ticket_id 1
    count 5
    price 1
  end
end
