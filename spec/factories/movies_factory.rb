FactoryBot.define do
  factory :movie, class: 'Api::V1::Movie' do
    title { 'Terminator' }
    description do
      'Two men arrive separately in 1984 Los Angeles, having time traveled from 2029. One is a cybernetic assassin known as a Terminator.'
    end
    gender { 'Action' }
    release_date { '2023-04-19' }
    added_date { '2023-04-19' }
    daily_rental_price { '9.99' }
    available { true }
  end
end
