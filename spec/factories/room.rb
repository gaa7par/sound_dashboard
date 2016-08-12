FactoryGirl.define do
  factory :room do
    sequence(:name) { |n| "name-#{n}" }
    dimension_x 30
    dimension_y 10
  end
end
