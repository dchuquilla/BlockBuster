# frozen_string_literal: true

# Rent entity
class Api::V1::Rent < ApplicationRecord
  self.table_name = 'rents'
  belongs_to :user
  belongs_to :movie
  has_one :ticket

  validates :rent_date, presence: true
  validates :rent_period, presence: true
  validates :total_price, presence: true, numericality: { greater_than: 0 }

  validate :return_date_cannot_be_in_the_past

  before_save :calculate_total_price
  after_create :create_related_ticket

  def return_date_cannot_be_in_the_past
    return unless return_date.present? && return_date < Date.today

    errors.add(:return_date, "can't be in the past")
  end

  private

  def calculate_total_price
    Rails.logger.info 'rent_period * movie.daily_rental_price'
    Rails.logger.info rent_period * movie.daily_rental_price
    self.total_price = rent_period * movie.daily_rental_price
  end

  def create_related_ticket
    ticket = Api::V1::Ticket.create(rent: self, code: "RENT-#{id.to_s.rjust(6, '0')}",
                                    issue_date: rent_date, total_price: total_price)
    ticket.save!
  end
end
