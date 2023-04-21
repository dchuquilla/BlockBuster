# frozen_string_literal: true

# Ticket entity
class Api::V1::Ticket < ApplicationRecord
  self.table_name = 'tickets'
  FINE_BASE = 5
  STATES = { new: 'New', apply: 'Apply Fine', ok: 'In period', returned: 'Returned' }

  belongs_to :rent
  has_one :movie, through: :rent

  validates :code, presence: true, uniqueness: true
  validates :issue_date, presence: true
  validates :total_price, presence: true, numericality: { greater_than: 0 }

  after_update :set_rent_return

  def fine_state
    return if state == STATES[:returned]

    DateTime.now > (issue_date + rent.rent_period.days) ? STATES[:apply] : STATES[:ok]
  end

  def total_fine
    rent.total_fine if state == STATES[:returned]

    extra_days = (DateTime.now.to_date - (issue_date + rent.rent_period.days).to_date).to_i
    if extra_days <= 0
      0
    else
      (FINE_BASE * extra_days).to_f.to_s
    end
  end

  def set_rent_return
    rent.update(return_date: Date.today, total_fine: total_fine) if state == STATES[:returned]
  end
end
