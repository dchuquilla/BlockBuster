# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Rent, type: :model do
  let(:movie) { FactoryBot.create(:movie, daily_rental_price: 10) }
  let(:user) { FactoryBot.create(:user) }

  describe 'validations' do
    subject(:rent) do
      described_class.new(rent_date: Date.today, rent_period: 1, total_price: 10, user: user,
                          movie: movie)
    end

    it { is_expected.to validate_presence_of(:rent_date) }
    it { is_expected.to validate_presence_of(:rent_period) }
    it { is_expected.to validate_presence_of(:total_price) }
    it { is_expected.to validate_numericality_of(:total_price).is_greater_than(0) }

    context 'when return_date is in the past' do
      before { rent.return_date = Date.yesterday }

      it { is_expected.not_to be_valid }

      it 'has proper error message' do
        rent.valid?
        expect(rent.errors[:return_date]).to include("can't be in the past")
      end
    end

    context 'when return_date is nil' do
      before { rent.return_date = nil }

      it { is_expected.to be_valid }
    end

    context 'when return_date is in the future' do
      before { rent.return_date = Date.tomorrow }

      it { is_expected.to be_valid }
    end
  end

  describe 'before commit' do
    it 'calculates total_price' do
      rent = FactoryBot.build(:rent,
                              {rent_date: Date.today, rent_period: 1, user: user, movie: movie})
      expect(rent.total_price).to eq(1.to_f)
      rent.save!
      expect(rent.total_price).to eq(10.to_f)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:movie) }
  end
end
