Admin.create!(email: "admin@example.com", password: "admin1", password_confirmation: "admin1")

names = ["Master Builders", "Other Room", "Yet Another"]

Date = [2016, 07, 28]
Period = 5

def random
  random = rand(3)
  if random == 0
    rand(11)
  elsif random == 1
    6
  else
    7
  end
end

def add_rooms(names)
  names.each do |name|
    unless Room.find_by(name: name)
      room = Room.create(name: name)
      add_recorders(room)
    end
  end
end

def add_recorders(room)
  (1..3).each do |number|
    recorder = room.recorders.create(name: "#{room.id}.#{number}")
    add_measurements(recorder)

    time = Time.new(*Date, 16)
    recorder.measurements.create!(measure: random, time: time)
  end
end

def add_measurements(recorder)
  (8..15).each do |hour|
    (0..59).each do |minute|
      if minute % Period == 0
        time = Time.new(*Date, hour, minute)
        recorder.measurements.create!(measure: random, time: time)
      end
    end
  end
end

add_rooms(names)
