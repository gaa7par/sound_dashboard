class Recorder < ApplicationRecord
  belongs_to :room
  has_many :measurements, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
