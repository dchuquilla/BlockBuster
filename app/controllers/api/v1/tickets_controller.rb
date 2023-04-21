class Api::V1::TicketsController < ApplicationController
  before_action :set_api_v1_ticket, only: %i[update destroy]
  before_action :set_api_v1_ticket_by_code, only: %i[show update]
  before_action :validate_admin_usaer, only: [:update]

  # GET /api/v1/tickets
  # GET /api/v1/tickets.json
  def index
    @tickets = Api::V1::Ticket.all
  end

  # GET /api/v1/tickets/1
  # GET /api/v1/tickets/1.json
  def show
    @ticket.update({state: @ticket.fine_state})
  end

  # POST /api/v1/tickets
  # POST /api/v1/tickets.json
  def create
    @ticket = Api::V1::Ticket.new(api_v1_ticket_params)

    if @ticket.save
      render :show, status: :created, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tickets/1
  # PATCH/PUT /api/v1/tickets/1.json
  def update
    if @ticket.update(api_v1_ticket_params)
      render :show, status: :ok, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tickets/1
  # DELETE /api/v1/tickets/1.json
  def destroy
    @ticket.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_ticket
    @ticket = Api::V1::Ticket.find(params[:id])
  end

  def set_api_v1_ticket_by_code
    render json: 'Code is required', staus: :unprocessable_entity unless params[:code].present?
    @ticket = Api::V1::Ticket.find_by(code: params[:code])
    render json: 'Ticket not found', status: :not_found if @ticket.nil?
  end

  # Only allow a list of trusted parameters through.
  def api_v1_ticket_params
    params.require(:api_v1_ticket).permit(:rent_id, :code, :issue_date, :total_price)
  end
end
