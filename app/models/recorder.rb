class Recorder < ApplicationRecord
  belongs_to :room
  validates :name, presence: true, uniqueness: true
end
