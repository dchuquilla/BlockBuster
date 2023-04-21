require 'rails_helper'

RSpec.describe '/api/v1/tickets', type: :request do
  let(:movie) { FactoryBot.create(:movie) }

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
      expect(json[:fine_state]).to eq('In period')
    end

    it 'shows ticket with fine' do
      rent = FactoryBot.create(:rent, {rent_period: 3, rent_date: 7.days.ago})
      get "/api/v1/tickets/validate/RENT-#{rent.id.to_s.rjust(6, '0')}.json", as: :json
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(response).to be_successful
      expect(json[:fine_state]).to eq('Apply Fine')
      expect(json[:total_fine]).to eq(20.to_f.to_s)
    end
  end

  # describe 'PATCH /update' do
  #   context 'with valid parameters' do
  #     let(:new_attributes) do
  #       skip('Add a hash of attributes valid for your model')
  #     end

  #     it 'updates the requested api_v1_ticket' do
  #       ticket = Api::V1::Ticket.create! valid_attributes
  #       patch api_v1_ticket_url(ticket),
  #             params: { api_v1_ticket: new_attributes }, headers: valid_headers, as: :json
  #       ticket.reload
  #       skip('Add assertions for updated state')
  #     end

  #     it 'renders a JSON response with the api_v1_ticket' do
  #       ticket = Api::V1::Ticket.create! valid_attributes
  #       patch api_v1_ticket_url(ticket),
  #             params: { api_v1_ticket: new_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:ok)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'renders a JSON response with errors for the api_v1_ticket' do
  #       ticket = Api::V1::Ticket.create! valid_attributes
  #       patch api_v1_ticket_url(ticket),
  #             params: { api_v1_ticket: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end
  # end

  # describe 'DELETE /destroy' do
  #   it 'destroys the requested api_v1_ticket' do
  #     ticket = Api::V1::Ticket.create! valid_attributes
  #     expect do
  #       delete api_v1_ticket_url(ticket), headers: valid_headers, as: :json
  #     end.to change(Api::V1::Ticket, :count).by(-1)
  #   end
  # end
end
