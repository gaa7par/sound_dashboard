class Room < ApplicationRecord
  has_many :recorders, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }

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
end
