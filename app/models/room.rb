class Room < ApplicationRecord
  has_many :recorders, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :dimension_x, :dimension_y, presence: true, numericality: { greater_than: 0 }

  def measures_per_days_chart(date = 'today')
    day = if date == 'today'
            Date.today
          elsif date == 'yesterday'
            Date.yesterday
          else
            Date.parse(date)
          end

    measures = Hash.new(0)

    recorders.each do |recorder|
      recorder.measurements.for_a_day(day).each do |measurement|
        measures[measurement.time.to_i] += measurement.measure
      end
    end

    measures.values.map { |measure| measure / recorders.count }
  end

  def coordinates_per_room_chart
    coordinates = Array.new

    (0...dimension_x).each do |x|
      (0...dimension_y).each do |y|
        coordinates << [x, y, 0]
      end
    end
    add_recorders_to_chart(coordinates)
  end

  private

  def add_recorders_to_chart(coordinates)
    x, y = 0, 0

    recorders.each do |recorder|
      x = recorder.position_x
      y = recorder.position_y
      coordinates << [x, y, 10]
    end
    coordinates
  end
end
