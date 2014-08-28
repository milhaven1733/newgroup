module Mine
  class TicketsController < ApplicationController
    before_action :set_ticket, only: [:show, :edit, :update, :destroy]

    # GET /tickets
    def index
      @tickets = current_user.tickets
    end

    # GET /tickets/1
    def show
    end

    # GET /tickets/new
    def new
      @ticket = Ticket.new
    end

    # GET /tickets/1/edit
    def edit
    end

    # POST /tickets
    def create
      @ticket = current_user.tickets.new(ticket_params)

      if @ticket.save
        redirect_to [:mine, @ticket], notice: 'Ticket was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /tickets/1
    def update
      if @ticket.update(ticket_params)
        redirect_to [:mine, @ticket], notice: 'Ticket was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /tickets/1
    def destroy
      @ticket.destroy
      redirect_to mine_tickets_path, notice: 'Ticket was successfully destroyed.'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = current_user.tickets.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:category_id, :name, :desc, :start_at, :end_at, :oprice, :amount, :image_url)
    end
  end
end
