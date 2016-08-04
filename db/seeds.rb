Admin.create!(email: "admin@example.com", password: "admin1", password_confirmation: "admin1")

DATE = [2016, 8, 5]
PERIOD = 5

names = ["Master Builders", "Other Room", "Yet Another"]

def random
  random = rand(5)
  if random == 0
    6
  elsif random == 1
    7
  else
    rand(11)
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

    time = Time.new(*DATE, 16)
    recorder.measurements.create!(measure: random, time: time)
  end
end

def add_measurements(recorder)
  (8..15).each do |hour|
    minute = 0

    while minute < 60
      time = Time.new(*DATE, hour, minute)
      recorder.measurements.create!(measure: random, time: time)
      minute += PERIOD
    end
  end
end

add_rooms(names)
