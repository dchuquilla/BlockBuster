require 'rails_helper'

RSpec.describe '/api/v1/tickets', type: :request do
  let(:user) { FactoryBot.create(:user, {is_admin: true}) }
  let(:movie) { FactoryBot.create(:movie) }
  let(:jwt_token) do
    post '/login', params: { user: { email: user.email, password: user.password } }
    response.header[:Authorization]
  end

  describe 'GET /api/v1/tickets/validate/${code}.json' do
    it 'renders a successful response' do
      rent = FactoryBot.create(:rent)
      get "/api/v1/tickets/validate/RENT-#{rent.id.to_s.rjust(6, '0')}.json", as: :json
      expect(response).to be_successful
    end

    it 'renders an unsuccessful response' do
      rent = FactoryBot.create(:rent)
      get "/api/v1/tickets/validate/CODE-#{rent.id.to_s.rjust(6, '0')}.json", as: :json
      expect(response).not_to be_successful
    end

    it 'shows ticket in period' do
      rent = FactoryBot.create(:rent, {rent_period: 10, rent_date: 1.week.ago})
      get "/api/v1/tickets/validate/RENT-#{rent.id.to_s.rjust(6, '0')}.json", as: :json
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(response).to be_successful
      expect(json[:state]).to eq('In period')
    end

    it 'shows ticket with fine' do
      rent = FactoryBot.create(:rent, {rent_period: 3, rent_date: 7.days.ago})
      get "/api/v1/tickets/validate/RENT-#{rent.id.to_s.rjust(6, '0')}.json", as: :json
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(response).to be_successful
      expect(json[:state]).to eq('Apply Fine')
      expect(json[:total_fine]).to eq(20.to_f.to_s)
    end
  end

  describe 'PATCH /api/v1/tickets/return/${code}.json' do
    it 'renders a successful response' do
      rent = FactoryBot.create(:rent)
      patch "/api/v1/tickets/return/RENT-#{rent.id.to_s.rjust(6, '0')}.json", as: :json,
                                                                              headers: { Authorization: jwt_token }
      expect(response).to be_successful
    end

    it 'renders an unsuccessful response' do
      rent = FactoryBot.create(:rent)
      patch "/api/v1/tickets/return/CODE-#{rent.id.to_s.rjust(6, '0')}.json", as: :json,
                                                                              headers: { Authorization: jwt_token }
      expect(response).not_to be_successful
    end

    it 'shows ticket in period' do
      rent = FactoryBot.create(:rent, {rent_period: 10, rent_date: 1.week.ago})
      patch "/api/v1/tickets/return/RENT-#{rent.id.to_s.rjust(6, '0')}.json", as: :json,
                                                                              headers: { Authorization: jwt_token }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(response).to be_successful
      expect(json[:state]).to eq('Returned')
    end

    it 'shows ticket with fine' do
      rent = FactoryBot.create(:rent, {rent_period: 3, rent_date: 7.days.ago})
      patch "/api/v1/tickets/return/RENT-#{rent.id.to_s.rjust(6, '0')}.json", as: :json,
                                                                              headers: { Authorization: jwt_token }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(response).to be_successful
      expect(json[:state]).to eq('Returned')
      expect(json[:total_fine]).to eq(20.to_f.to_s)
    end
  end
end
