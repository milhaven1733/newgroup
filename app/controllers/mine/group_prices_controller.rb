module Mine
  class GroupPricesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_ticket

    def new
      redirect_to root_path unless current_user.merchant?
      @group_prices = GroupPrice.where("ticket_id = ?", @ticket.id).order(:range_from)
      @group_price = GroupPrice.new
    end

    def create
      @group_price = @ticket.group_prices.new(group_price_param)
      if @group_price.save
        @group_prices = GroupPrice.where("ticket_id = ?", @ticket.id)
        render json: @group_prices
      else
        render json: { error_code: 0 }
      end
    end

    def destroy
      @group_price = GroupPrice.find(params[:id])
      @group_price.destroy
    end
 
    private

    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    def group_price_param
      params.require(:group_price).permit(:range_from, :range_to, :price)
    end
  end
end
