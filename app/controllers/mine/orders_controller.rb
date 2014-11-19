module Mine
  class OrdersController < ApplicationController
    before_action :authenticate_user!
    
    def index
      @orders = current_user.orders.order(id: :desc).page params[:page]
    end

    def show
      @order = current_user.orders.find params[:id]
    end
    
    def create
      @order = current_user.orders.new(order_params.merge(status: :created))
      if @order.save
        render :checkout
      else
        render ticket_path(params[:ticket_id]), notice: "Please check input again."
      end
    end
    
    def update
      #TODO: Deal with payment thing
    end
    
    private
    
    def order_params
      params.require(:order).permit(:ticket_id, :count, :price, :booking_fee)
    end
    
  end
end
