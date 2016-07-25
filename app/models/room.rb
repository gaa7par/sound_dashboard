class Room < ApplicationRecord
  has_many :recorders
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
end
