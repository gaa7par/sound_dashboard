class Measurement < ApplicationRecord
  belongs_to :recorder

  validates :measure, :time, presence: true
end
