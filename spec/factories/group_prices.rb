FactoryGirl.define do
  factory :group_price do
    range_from 5
    range_to 10
    discount 30
    factory :group_price2 do
      range_from 11
      range_to 20
      discount 50
    end
  end
end