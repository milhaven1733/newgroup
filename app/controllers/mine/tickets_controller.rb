module Mine
  class TicketsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_ticket, only: [:show, :edit, :update, :destroy]
    authorize_resource

    # GET /tickets
    def index
      @q = Ticket.ransack(params[:q])
      @tickets = @q.result.where(user_id: current_user.id).page(params[:page]).per_page(20)
    end

    # GET /tickets/1
    def show
    end

    # GET /tickets/new
    def new
      redirect_to user_session_path unless current_user && current_user.merchant?
      @ticket = Ticket.new
      @ticket.group_prices.build
    end

    # GET /tickets/1/edit
    def edit
    end

    # POST /tickets
    def create
      @ticket = current_user.tickets.new(ticket_params)
      if @ticket.save
        respond_to do |format|
          format.html { redirect_to [:mine, @ticket], notice: 'Ticket was successfully created.' }
          format.json { render json: @ticket }
        end
      else
        respond_to do |formant|
          format.html { render :new, notice: 'Faild to create new ticket, please try again.' }
          format.json { render json: { error_code: 0 } }
        end
      end
    rescue Exception => e
      @ticket = Ticket.new(ticket_params)
      flash[:error] = e.inspect
      render :new
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
      redirect_to mine_tickets_path, notice: 'Listing was successfully deleted.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = current_user.tickets.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      change_params_year_format params      
      params.require(:ticket).permit(
        :city,
        :category_id,
        :name,
        :desc, 
        :start_at,
        :end_at,
        :amount,
        :minimum_amount,
        :oprice,
        :flatten_discount,
        :flatten_price,
        :student_discount,
        :shipping,
        :will_call,
        :service_fee_waived,
        :image,
        :sitting_map,
        group_prices_attributes: [:range_from, :range_to, :price]
      )
    end

    def format_time time
      return "" if time.blank?
      time_ary = time.split("/")
      [time_ary[1], time_ary[0], time_ary[2]].join("/").try(:to_datetime).try(:to_s, :db)
    end

    def change_params_year_format params
      params[:ticket][:start_at] = format_time params[:ticket][:start_at]
      params[:ticket][:end_at] = format_time params[:ticket][:end_at]
      params
    end
  end

end
