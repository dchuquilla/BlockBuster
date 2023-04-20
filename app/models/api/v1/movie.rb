class Api::V1::Movie < ApplicationRecord
  has_many :rentals
  validates :title, presence: true
  validates :description, presence: true
  validates :gender, presence: true
  validates :added_date, presence: true
  validates :daily_rental_price, presence: true
  validates :available, inclusion: { in: [true, false] }

  scope :available, -> { where(available: true) }
end
