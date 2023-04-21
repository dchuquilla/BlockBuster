class Api::V1::Rent < ApplicationRecord
  belongs_to :user
  belongs_to :movie
end
