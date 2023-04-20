# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Movie, type: :model do
  let(:movie) { FactoryBot.build(:movie) }

  context 'valid Factory' do
    it 'has a valid factory' do
      expect(movie).to be_valid
    end
  end

  describe 'validations' do
    it 'is not valid without a title' do
      movie.title = nil
      expect(movie).not_to be_valid
    end

    it 'is not valid without a description' do
      movie.description = nil
      expect(movie).not_to be_valid
    end

    it 'is not valid without a gender' do
      movie.gender = nil
      expect(movie).not_to be_valid
    end

    it 'is not valid without a added_date' do
      movie.added_date = nil
      expect(movie).not_to be_valid
    end

    it 'is not valid without a daily_rental_price' do
      movie.daily_rental_price = nil
      expect(movie).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:rentals) }
  end

  describe 'scopes' do
    describe '.available' do
      let!(:available_movie) { FactoryBot.create(:movie, available: true) }
      let!(:unavailable_movie) { FactoryBot.create(:movie, available: false) }

      it 'returns only available movies' do
        expect(described_class.available).to contain_exactly(available_movie)
      end
    end
  end
end
