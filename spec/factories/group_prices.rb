FactoryGirl.define do
  factory :group_price do
    ticket_id 1
    range_from 5
    range_to 10
    oprice 100
    discount 50
    student_discount 10
    price 50
  end
end