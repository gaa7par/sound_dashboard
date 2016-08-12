class Recorder < ApplicationRecord
  belongs_to :room
  has_many :measurements, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :position_x, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: Proc.new { |r| r.room.dimension_x } }
  validates :position_y, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: Proc.new { |r| r.room.dimension_y } }
end
