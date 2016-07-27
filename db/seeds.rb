Admin.create!(email: "admin@sound_dashboard.com",
  password: "admin1", password_confirmation: "admin1")

Room.create!(name: "Master Builders")
Room.create!(name: "Other Room")
Room.create!(name: "Yet Another")



(1..3).each do |room_id|
  (1..3).each do |n|
    Recorder.create!(name: "#{room_id}.#{n}", room_id: room_id)
  end
end

(1..9).each do |recorder_id|
  (8..16).each do |n|
    measure = rand(10)
    time = Time.new(2016, 07, 27, n, 0, 0)

    Measurement.create!(measure: measure, time: time, recorder_id: recorder_id)
  end
end
