class ProfileController < ApplicationController
  before_action :set_user, only: [:merchant]

  def merchant
    @top_tickets = Ticket.top_deals
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
