class ProfileController < ApplicationController
  before_action :set_user

  def merchant
    return unless @user.merchant?
    @top_tickets = Ticket.top_deals
  end

  def user
    return if @user.merchant?
    #TODO: what is the defination of favorite shows? 
    @favorite_shows = Ticket.last(6)
    #TODO: What is the defination of favorite venues
    @favorite_venues = Ticket.last(6)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
