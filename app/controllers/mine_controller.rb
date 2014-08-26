class MineController < ApplicationController

  def tickets
    @tickets = current_user.tickets
    render 'tickets/index'
  end
end
