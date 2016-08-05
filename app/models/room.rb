class Room < ApplicationRecord
  has_many :recorders, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }

  PERIOD = 5

  def measures_per_days_chart(days = 1)
    measures = Hash.new(0)
    measures_per_days = (8 * days)  * (60 / PERIOD) + 1 # (8 hours per day * days)  * PERIOD + 1
    number_of_recorders = recorders.count

    recorders.each do |recorder|
      recorder.measurements.each do |measurement|
        measures[measurement.time.to_i] += measurement.measure
      end
    end

    result = measures.values.map { |measure| measure / number_of_recorders }
    result[0...measures_per_days]
  end
end
