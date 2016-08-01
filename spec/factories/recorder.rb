FactoryGirl.define do
  factory :recorder do
    sequence(:name) { |n| "name-#{n}" }
    room { create(:room) }
  end
end
