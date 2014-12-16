module Mine
  class GroupPricesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_ticket

    def new
      redirect_to root_path unless current_user.merchant?
    end

    def create
      @group_price = @ticket.group_prices.new(group_price_param)
      if @group_price.save
        redirect_to [:mine, @ticket], notice: 'Create Price Tier Success'
      else
        flash[:error] = @group_price.errors.full_messages.join(', ')
        render :new
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
      params.require(:group_price).permit(:range_from, :range_to, :discount)
    end
  end
end
