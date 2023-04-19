# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /login', type: :request do
  let(:user) { FactoryBot.create(:user, email: 'dario.chuquilla@gmail.com', password: 'test1234.') }

  describe 'POST /login' do
    context 'with valid params' do
      it 'returns a success status code' do
        post '/login', params: { user: { email: user.email, password: user.password } }
        expect(response).to have_http_status(:success)
      end

      it 'returns a JWT token' do
        post '/login', params: { user: { email: user.email, password: user.password } }
        expect(response.header).to have_key('Authorization')
      end
    end

    context 'with invalid params' do
      it 'returns an error status code for an incorrect email' do
        post '/login', params: { user: { email: 'invalid-email', password: user.password } }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error status code for an incorrect password' do
        post '/login', params: { user: { email: user.email, password: 'incorrect-password' } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
