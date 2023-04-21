# frozen_string_literal: true

# Ticket entity
class Api::V1::Ticket < ApplicationRecord
  self.table_name = 'tickets'
  FINE_BASE = 5
  belongs_to :rent
  has_one :movie, through: :rent

  validates :code, presence: true, uniqueness: true
  validates :issue_date, presence: true
  validates :total_price, presence: true, numericality: { greater_than: 0 }

  def fine_state
    DateTime.now > (issue_date + rent.rent_period.days) ? 'Apply Fine' : 'In period'
  end

  def total_fine
    extra_days = (DateTime.now.to_date - (issue_date + rent.rent_period.days).to_date).to_i
    if extra_days <= 0
      0
    else
      (FINE_BASE * extra_days).to_f.to_s
    end
  end
end
