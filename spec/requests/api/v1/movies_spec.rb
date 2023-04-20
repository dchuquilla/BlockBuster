# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'movies index', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:movies) { FactoryBot.create_list(:movie, 100) }
  let(:jwt_token) do
    post '/login', params: { user: { email: user.email, password: user.password } }
    response.header[:Authorization]
  end

  describe 'GET /api/v1/movies.json' do
    context 'without params' do
      it 'returns a success status code' do
        get '/api/v1/movies.json', headers: { Authorization: jwt_token }
        expect(response).to have_http_status(:success)
      end

      it 'contains the movie title created' do
        movie = FactoryBot.create(:movie)
        get '/api/v1/movies.json', headers: { Authorization: jwt_token }
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:data].first[:title]).to eq(movie.title)
      end
    end

    context 'with params' do
      it 'paginates by 25 per page' do
        total_movies = movies.count
        total_pages = total_movies / 25
        get '/api/v1/movies.json?page=2&per_page=25', headers: { Authorization: jwt_token }
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:pagination][:count]).to eq(total_movies)
        expect(json[:pagination][:total_pages]).to eq(total_pages)
        expect(json[:pagination][:previous_page]).to eq(1)
        expect(json[:pagination][:next_page]).to eq(3)
      end

      it 'sorts by added_date' do
        total_movies = movies.count
        movie = FactoryBot.create(:movie, {added_date: DateTime.now})
        get '/api/v1/movies.json?sort=added_date:desc', headers: { Authorization: jwt_token }
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:pagination][:count]).to eq(total_movies + 1)
        expect(json[:data].first[:title]).to eq(movie.title)
      end

      it 'filters by rental price' do
        movie = FactoryBot.create(:movie, {daily_rental_price: 40})
        FactoryBot.create(:movie, {daily_rental_price: 20})
        FactoryBot.create(:movie, {daily_rental_price: 65})
        FactoryBot.create(:movie, {daily_rental_price: 10})
        FactoryBot.create(:movie, {daily_rental_price: 30})
        get '/api/v1/movies.json?filter[daily_rental_price][lte]=40&sort=daily_rental_price:desc',
            headers: { Authorization: jwt_token }
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:data].first[:title]).to eq(movie.title)
      end

      it 'searches by title' do
        movies
        FactoryBot.create(:movie, {title: 'The Prestige'})
        get '/api/v1/movies.json?search_for=Prestige', headers: { Authorization: jwt_token }
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:data].size).to be >= 1
      end
    end
  end
end
