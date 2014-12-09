FactoryGirl.define do
  factory :ticket do
    user_id 1
    name 'ticket'
    desc 'HHHHHH'
    start_at { Time.now }
    amount 100
    category_id 1
    city "Philadelphia"
    minimum_amount 5
    end_at { Time.now + 1.hour }
    
    factory :price_tier do
      after(:create) do |ticket|
        create(:group_price, ticket: ticket)
      end
    end
  end
end