FactoryBot.define do
  factory :api_v1_ticket, class: 'Api::V1::Ticket' do
    rent { nil }
    code { "MyString" }
    issue_date { "2023-04-21" }
    total_price { "9.99" }
  end
end
