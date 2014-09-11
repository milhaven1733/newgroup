class MineController < ApplicationController
  before_action :set_current

  def profile
    @favourite_tickets = @user.favourites
  end

  def update_profile
    current_user.update user_param
    redirect_to action: :profile
  end

  private

  def set_current
    @user = current_user || current_merchant
  end

  def user_param
    if current_user.merchant?
      params.require(:user).permit(:name, :phone, :avatar, :address)
    else
      params.require(:user).permit(:name, :avatar)
    end
  end
end
