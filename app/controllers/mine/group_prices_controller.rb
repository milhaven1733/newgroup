module Mine
  class GroupPricesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_ticket

    def new
      redirect_to root_path unless current_user.merchant?
      @group_prices = GroupPrice.where("ticket_id = ?", @ticket.id)
      @group_price = GroupPrice.new
    end

    def create
      @group_price = @ticket.group_prices.new(group_price_param)
      if @group_price.save
        redirect_to [:mine, @ticket], notice: "Group Price for Ticket #{@ticket.id} Create Successly"
      else
        render action: :new, alert: 'Group Price Create Fail'
      end
    end

    def destroy
      @group_price = GroupPrice.find params[:id]
      @group_price.destroy
    end

    private

    def set_ticket
      @ticket = Ticket.find params[:ticket_id]
    end

    def group_price_param
      params.require(:group_price).permit(:range_from, :range_to, :price)
    end
  end
end
