FactoryGirl.define do
  factory :room do
    sequence(:name) { |n| "name-#{n}" }
    dimension_x 30
    dimension_y 10
  end

  factory :room2 do
    sequence(:name) { |n| "name-#{n}" }
    dimension_x 3
    dimension_y 2
  end
end
