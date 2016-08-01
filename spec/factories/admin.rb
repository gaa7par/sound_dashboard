FactoryGirl.define do
  factory :admin do
    sequence(:email) { |n| "email-#{n}@example.com" }
    password 'secret'
    password_confirmation 'secret'
  end
end
