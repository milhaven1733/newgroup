FactoryGirl.define do
  factory :ticket do
    user_id 1
    name 'ticket'
    desc 'HHHHHH'
    start_at { Time.now }
    oprice 100
    amount 100
    category_id 1
    city "Philadelphia"
    flat_price 20
    flat_discount 80
    minimum_amount 5
    end_at { Time.now + 1.hour }
  end
end