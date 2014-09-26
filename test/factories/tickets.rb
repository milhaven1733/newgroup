FactoryGirl.define do
  factory :ticket do
    user_id 1
    name 'ticket'
    desc 'HHHHHH'
    sequence(:start_at) { Time.now }
    sequence(:end_at) { 1.days.since }
    oprice 100
    amount 100
    category_id 1
    city "NewYork"
  end
end