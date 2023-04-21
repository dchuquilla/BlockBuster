# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/rents', type: :request do
  # describe 'GET /index' do
  #   it 'renders a successful response' do
  #     Api::V1::Rent.create! valid_attributes
  #     get api_v1_rents_url, headers: valid_headers, as: :json
  #     expect(response).to be_successful
  #   end
  # end

  # describe 'GET /show' do
  #   it 'renders a successful response' do
  #     rent = Api::V1::Rent.create! valid_attributes
  #     get api_v1_rent_url(rent), as: :json
  #     expect(response).to be_successful
  #   end
  # end

  # describe 'POST /create' do
  #   context 'with valid parameters' do
  #     it 'creates a new Api::V1::Rent' do
  #       expect do
  #         post api_v1_rents_url,
  #              params: { api_v1_rent: valid_attributes }, headers: valid_headers, as: :json
  #       end.to change(Api::V1::Rent, :count).by(1)
  #     end

  #     it 'renders a JSON response with the new api_v1_rent' do
  #       post api_v1_rents_url,
  #            params: { api_v1_rent: valid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:created)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'does not create a new Api::V1::Rent' do
  #       expect do
  #         post api_v1_rents_url, params: { api_v1_rent: invalid_attributes }, as: :json
  #       end.not_to change(Api::V1::Rent, :count)
  #     end

  #     it 'renders a JSON response with errors for the new api_v1_rent' do
  #       post api_v1_rents_url,
  #            params: { api_v1_rent: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end
  # end

  # describe 'PATCH /update' do
  #   context 'with valid parameters' do
  #     let(:new_attributes) do
  #       skip('Add a hash of attributes valid for your model')
  #     end

  #     it 'updates the requested api_v1_rent' do
  #       rent = Api::V1::Rent.create! valid_attributes
  #       patch api_v1_rent_url(rent),
  #             params: { api_v1_rent: new_attributes }, headers: valid_headers, as: :json
  #       rent.reload
  #       skip('Add assertions for updated state')
  #     end

  #     it 'renders a JSON response with the api_v1_rent' do
  #       rent = Api::V1::Rent.create! valid_attributes
  #       patch api_v1_rent_url(rent),
  #             params: { api_v1_rent: new_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:ok)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'renders a JSON response with errors for the api_v1_rent' do
  #       rent = Api::V1::Rent.create! valid_attributes
  #       patch api_v1_rent_url(rent),
  #             params: { api_v1_rent: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end
  # end

  # describe 'DELETE /destroy' do
  #   it 'destroys the requested api_v1_rent' do
  #     rent = Api::V1::Rent.create! valid_attributes
  #     expect do
  #       delete api_v1_rent_url(rent), headers: valid_headers, as: :json
  #     end.to change(Api::V1::Rent, :count).by(-1)
  #   end
  # end
end
