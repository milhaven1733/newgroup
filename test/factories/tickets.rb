FactoryGirl.define do
  factory :ticket do
    user_id 1
    name 'ticket'
    desc 'HHHHHH'
    sequence(:start_at) { Time.now }
    oprice 100
    amount 100
    category_id 1
    city "Philadelphia"
    flat_price 80
  end
end