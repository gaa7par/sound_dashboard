class Recorder < ApplicationRecord
  belongs_to :room
  has_many :measurements

  validates :name, presence: true, uniqueness: true
end
