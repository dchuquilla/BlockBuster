# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :rent, class: 'Api::V1::Rent' do
    user { FactoryBot.create(:user, {email: 'rental_user@mail.com'}) }
    movie { FactoryBot.create(:movie) }
    rent_date { Faker::Date.between_except(from: 1.month.ago, to: 1.day.ago, excepted: Date.today) }
    rent_period { 1 }
    total_price { 1 }
  end
end
