class Api::V1::RentsController < ApplicationController
  before_action :set_api_v1_rent, only: %i[ show update destroy ]

  # GET /api/v1/rents
  # GET /api/v1/rents.json
  def index
    @api_v1_rents = Api::V1::Rent.all
  end

  # GET /api/v1/rents/1
  # GET /api/v1/rents/1.json
  def show
  end

  # POST /api/v1/rents
  # POST /api/v1/rents.json
  def create
    @api_v1_rent = Api::V1::Rent.new(api_v1_rent_params)

    if @api_v1_rent.save
      render :show, status: :created, location: @api_v1_rent
    else
      render json: @api_v1_rent.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/rents/1
  # PATCH/PUT /api/v1/rents/1.json
  def update
    if @api_v1_rent.update(api_v1_rent_params)
      render :show, status: :ok, location: @api_v1_rent
    else
      render json: @api_v1_rent.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/rents/1
  # DELETE /api/v1/rents/1.json
  def destroy
    @api_v1_rent.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_rent
      @api_v1_rent = Api::V1::Rent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_rent_params
      params.require(:api_v1_rent).permit(:user_id, :movie_id, :rent_date, :return_date, :rent_period, :total_price, :total_fine)
    end
end
