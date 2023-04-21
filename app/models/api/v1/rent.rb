# frozen_string_literal: true

# Rent entity
class Api::V1::Rent < ApplicationRecord
  self.table_name = 'rents'
  belongs_to :user
  belongs_to :movie

  validates :rent_date, presence: true
  validates :rent_period, presence: true
  validates :total_price, presence: true, numericality: { greater_than: 0 }

  validate :return_date_cannot_be_in_the_past

  before_save :calculate_total_price

  def return_date_cannot_be_in_the_past
    return unless return_date.present? && return_date < Date.today

    errors.add(:return_date, "can't be in the past")
  end

  private

  def calculate_total_price
    self.total_price = rent_period * movie.daily_rental_price
  end
end
