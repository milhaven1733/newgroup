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
    factory :ticket_with_group_prices do
      after(:create) do |ticket|
        ticket.group_prices << [build(:group_price), build(:group_price2)]
        ticket.save!
      end
    end
  end
end