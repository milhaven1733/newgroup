class MineController < ApplicationController
  before_action :set_current

  def profile
  end

  def update_profile
    
  end

  private
  def set_current
    @user = current_user || current_merchant
  end

end
