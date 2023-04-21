# frozen_string_literal: true

# Ticket entity
class Api::V1::Ticket < ApplicationRecord
  self.table_name = 'tickets'
  belongs_to :rent
end
