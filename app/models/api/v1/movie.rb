# frozen_string_literal: true

# Movie entity
class Api::V1::Movie < ApplicationRecord
  self.table_name = 'movies'
  has_many :rents
  validates :title, presence: true
  validates :description, presence: true
  validates :gender, presence: true
  validates :added_date, presence: true
  validates :daily_rental_price, presence: true
  validates :available, inclusion: { in: [true, false] }

  scope :available, -> { where(available: true) }
end
