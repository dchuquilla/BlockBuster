# frozen_string_literal: true

# add state field to tickets table
class AddStateToTicket < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :state, :string, null: false, default: Api::V1::Ticket::STATES[:new]
  end
end
