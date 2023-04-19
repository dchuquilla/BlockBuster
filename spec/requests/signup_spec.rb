# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /signup', type: :request do
  let(:user_params) do
    {
      user: {
        email: 'user@mail.com',
        password: 'test1234.'
      }
    }
  end

  describe 'POST /signup' do
    context 'with valid params' do
      it 'creates a new user' do
        expect do
          post '/signup', params: user_params
        end.to change(User, :count).by(1)
      end

      it 'returns a success status code' do
        post '/signup', params: user_params
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      it 'does not create a new user with an repeated email' do
        expect do
          post '/signup', params: user_params
        end.to change(User, :count)
        expect do
          post '/signup', params: user_params
        end.not_to change(User, :count)
      end

      it 'does not create a new user with an invalid email' do
        user_params[:user][:email] = 'invalid-email'
        expect do
          post '/signup', params: user_params
        end.not_to change(User, :count)
      end

      it 'does not create a new user with a short password' do
        user_params[:user][:password] = 'test'
        expect do
          post '/signup', params: user_params
        end.not_to change(User, :count)
      end

      it 'returns an error status code' do
        user_params[:user][:email] = 'invalid-email'
        post '/signup', params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
