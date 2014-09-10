# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    token "MyString"
    customer_id "somethings"
    transaction_type :recharge
    dollar 1
    status :created
    user_id 1
  end
end
