class Api::V1::MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_api_v1_movie, only: %i[show update destroy]
  before_action :validate_admin_usaer, only: %i[update cretae]

  # GET /api/v1/movies
  # GET /api/v1/movies.json
  def index
    @query_helper.update(query: Api::V1::Movie.all, search_fields: ['title'])
    @movies = @query_helper.results
  end

  # GET /api/v1/movies/1
  # GET /api/v1/movies/1.json
  def show; end

  # POST /api/v1/movies
  # POST /api/v1/movies.json
  def create
    @movie = Api::V1::Movie.new(api_v1_movie_params)

    if @movie.save
      render :show, status: :created, location: @movie
    else
      Rails.logger.infop '@movie.errors'
      Rails.logger.infop @movie.errors
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/movies/1
  # PATCH/PUT /api/v1/movies/1.json
  def update
    if @movie.update(api_v1_movie_params)
      render :show, status: :ok, location: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/movies/1
  # DELETE /api/v1/movies/1.json
  def destroy
    @movie.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_movie
    @movie = Api::V1::Movie.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def api_v1_movie_params
    params.require(:api_v1_movie).permit(:title, :description, :gender, :release_date,
                                         :added_date, :daily_rental_price, :available)
  end
end
