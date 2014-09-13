FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "bababab#{n}" }
  end
end
