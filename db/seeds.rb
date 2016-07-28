Admin.create!(email: "admin@example.com",
  password: "admin1", password_confirmation: "admin1")

names = ["Master Builders", "Other Room", "Yet Another"]

date = [2016, 07, 27]
period = 5

names.each do |name|
  unless Room.find_by(name: name)
    room = Room.create(name: name)

    (1..3).each do |number|
      recorder = room.recorders.create(name: "#{room.id}.#{number}")

      (8..15).each do |hour|
        (0..59).each do |minute|
          if minute % period == 0
            time = Time.new(*date, hour, minute)
            recorder.measurements.create!(measure: rand(11), time: time)
          end
        end
      end
    end
  end
end
