class MineController < ApplicationController
  before_action :set_current

  def profile
    @favourite_tickets = @user.favourites
    @user.merchant_info ||= @user.build_merchant_info
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
    post_params = [:name,
                   :zipcode,
                   :avatar,
                   :phone,
                   :group_name,
                   :number_of_group_members,
                   :university,
                   :wallet_link,
                   :billing_address]
                   
    if current_user.merchant?
      post_params << { merchant_info_attributes: [:latitude,
                                         :longitude,
                                         :url,
                                         :workday_opening_time,
                                         :sat_opening_time,
                                         :sun_opening_time,
                                         :orgnization,
                                         :sale_email,
                                         :sale_phone] }
    end
    params.require(:user).permit(post_params)
  end
end
