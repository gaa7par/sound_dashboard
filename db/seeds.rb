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

def random_position(parent_dimension)
  position = rand(parent_dimension)
  return position > 0 ? position : random_position(parent_dimension)
end

def add_rooms(names)
  names.each do |name|
    unless Room.find_by(name: name)
      room = Room.create(name: name, dimension_x: 30.0, dimension_y: 10.0)
      add_recorders(room)
    end
  end
end

def add_recorders(room)
  (1..3).each do |number|
    recorder = room.recorders.create(name: "#{room.id}.#{number}", position_x: random_position(room.dimension_x), position_y: random_position(room.dimension_y))
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
  end
  time = Time.new(*DATES[day], 16)
  recorder.measurements.create!(measure: random, time: time)
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
