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
    oprice 100
    student_discount 10
  end
end