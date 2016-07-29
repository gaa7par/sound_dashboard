FactoryGirl.define do
  factory :room do
    sequence(:name) { |n| "name-#{n}" }
  end
end
