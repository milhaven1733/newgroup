class ProfileController < ApplicationController
  before_action :set_user

  def merchant
    redirect_to :back and return unless @user.merchant?
      
    @tickets_search = TicketsSearch.new
    @top_tickets = @user.top_deals
    @more_tickets = @user.more_tickets
    respond_to do |format|
      format.html {render "merchant"}
      format.js
    end
  end

  def user
    redirect_to :back and return if @user.merchant?
    @favorite_shows = @user.favourites
    @favorite_venues = @user.favorite_merchants
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
