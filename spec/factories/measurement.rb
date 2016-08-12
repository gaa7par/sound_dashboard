FactoryGirl.define do
  factory :measurement do
    measure 7
    time Time.now
    recorder { create(:recorder) }
  end
end
