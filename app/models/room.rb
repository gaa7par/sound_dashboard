class Room < ApplicationRecord
  has_many :recorders, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
end
