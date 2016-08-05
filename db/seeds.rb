Admin.create!(email: "admin@example.com", password: "admin1", password_confirmation: "admin1")

DATES = [[2016, 8, 4], [2016, 8, 5], [2016, 8, 8], [2016, 8, 9], [2016, 8, 10], [2016, 8, 11], [2016, 8, 12]]
DAYS = DATES.count
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
  end
end

def add_measurements(recorder, day = 0)
  (8..15).each do |hour|
    minute = 0

    while minute < 60
      time = Time.new(*DATES[day], hour, minute)
      recorder.measurements.create!(measure: random, time: time)
      minute += PERIOD
    end

    time = Time.new(*DATES[day], 16)
    recorder.measurements.create!(measure: random, time: time)
  end
end

def add_more_days
  rooms = Room.all

  rooms.each do |room|
    room.recorders.each do |recorder|
      day = 0

      while day < DAYS
        add_measurements(recorder, day)
        day += 1
      end
    end
  end
end

add_rooms(names)
add_more_days
