class ProfileController < ApplicationController
  before_action :set_user

  def merchant
    return unless @user.merchant?
    @top_tickets = Ticket.top_deals
  end

  def user
    return if @user.merchant?
    @favorite_shows = @user.favourites
    @favorite_venues = Ticket.last(6)
  end

  def like
    return if current_user == @user
    if !current_user.voted?(@user)
      current_user.favorite_merchants << @user
    else
      current_user.favorite_merchants.delete(@user)
    end
    respond_to do |format|
      format.js
    end
  end
  private

  def set_user
    @user = User.find(params[:id])
  end
end
