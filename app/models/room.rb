class Room < ApplicationRecord
  has_many :recorders, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }

  def measures_for_current_day_chart
    measures = Hash.new(0)

    recorders.each do |recorder|
      recorder.measurements.each do |measurement|
        measures[measurement.time.to_i] += measurement.measure
      end
    end
    measures.values.map { |n| n / 3 }
  end
end
