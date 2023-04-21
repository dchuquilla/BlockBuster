FactoryBot.define do
  factory :api_v1_rent, class: 'Api::V1::Rent' do
    user { nil }
    movie { nil }
    rent_date { "2023-04-21" }
    return_date { "2023-04-21" }
    rent_period { 1 }
    total_price { "9.99" }
    total_fine { "9.99" }
  end
end
