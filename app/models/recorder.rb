class Recorder < ApplicationRecord
  belongs_to :room
  has_many :measurements, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :position_x, :position_y, presence: true, numericality: { greater_than: 0 }
end
