class ProfileController < ApplicationController
  before_action :set_user, only: [:user, :merchant]

  def user
  end

  def merchant
    @top_tickets = Ticket.top_deals
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
