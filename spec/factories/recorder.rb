FactoryGirl.define do
  factory :recorder do
    sequence(:name) { |n| "name-#{n}" }
    position_x 20
    position_y 5
    room { create(:room) }
  end

  factory :recorder2 do
    sequence(:name) { |n| "|name-#{n}" }
    position_x 1
    position_y 1
  end
end
