# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :movie, class: 'Api::V1::Movie' do
    title { Faker::Movie.title }
    description { Faker::Movie.quote }
    gender { 'Action' }
    release_date { '2023-04-19' }
    added_date do
      Faker::Date.between_except(from: 2.year.ago, to: 1.month.ago, excepted: Date.today)
    end
    daily_rental_price { Faker::Number.decimal(l_digits: 2) }
    available { Faker::Boolean.boolean }
  end
end
