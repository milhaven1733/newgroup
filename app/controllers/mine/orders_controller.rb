module Mine
  class OrdersController < ApplicationController
    def index
      @orders = current_user.orders.order(id: :desc).page params[:page]
    end

    def show
      @order = current_user.orders.find params[:id]
    end
  end
end
