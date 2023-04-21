class Api::V1::TicketsController < ApplicationController
  before_action :set_api_v1_ticket, only: %i[ show update destroy ]

  # GET /api/v1/tickets
  # GET /api/v1/tickets.json
  def index
    @api_v1_tickets = Api::V1::Ticket.all
  end

  # GET /api/v1/tickets/1
  # GET /api/v1/tickets/1.json
  def show
  end

  # POST /api/v1/tickets
  # POST /api/v1/tickets.json
  def create
    @api_v1_ticket = Api::V1::Ticket.new(api_v1_ticket_params)

    if @api_v1_ticket.save
      render :show, status: :created, location: @api_v1_ticket
    else
      render json: @api_v1_ticket.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tickets/1
  # PATCH/PUT /api/v1/tickets/1.json
  def update
    if @api_v1_ticket.update(api_v1_ticket_params)
      render :show, status: :ok, location: @api_v1_ticket
    else
      render json: @api_v1_ticket.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tickets/1
  # DELETE /api/v1/tickets/1.json
  def destroy
    @api_v1_ticket.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_ticket
      @api_v1_ticket = Api::V1::Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_ticket_params
      params.require(:api_v1_ticket).permit(:rent_id, :code, :issue_date, :total_price)
    end
end
