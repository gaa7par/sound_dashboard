FactoryGirl.define do
  factory :recorder do
    sequence(:name) { |n| "name-#{n}" }
    position_x 20
    position_y 5
    room { create(:room) }
  end
end
