module Mine
  class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_order, only: :checkout
    
    def index
      @orders = current_user.orders.order(id: :desc).page params[:page]
    end

    def show
      @order = current_user.orders.find params[:id]
    end
    
    def update
      #TODO: Deal with payment thing
    end
    
    private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:ticket_id, :count)
    end
    
  end
end
