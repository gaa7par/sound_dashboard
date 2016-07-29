class Measurement < ApplicationRecord
  belongs_to :recorder

  validates :measure, :time, presence: true

  scope :by_created_at, -> { order(:created_at) }
  end
