class Measurement < ApplicationRecord
  belongs_to :recorder

  validates :measure, :time, presence: true

  scope :by_created_at, -> { order(:created_at) }
  scope :for_a_day, -> (day) { where("time >= :start AND time <= :end", start: day.beginning_of_day, end: day.end_of_day) }
end
