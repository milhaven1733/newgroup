class MineController < ApplicationController
  before_action :set_current

  def profile
    @favourite_tickets = @user.favourites
  end

  def update_profile
    final_param = @user.merchant? ? merchant_param : user_param
    if @user.update(final_param)
      redirect_to action: :profile
    else
      render mine_edit_profile_path, error: @user.errors.full_messages.join(', ')
    end
  end
  
  def edit_profile
    @merchant_info = @user.merchant_info || MerchantInfo.new(user_id: @user.id) if @user.merchant?
  end

  private

  def set_current
    @user = current_user
  end

  def merchant_param
    params.require(:user).permit(:name,
                                 :zipcode,
                                 :avatar,
                                 :phone,
                                 :group_name,
                                 :number_of_group_members,
                                 :university,
                                 :wallet_link,
                                 :billing_address,
                                 merchant_info_attributes:
                                   [:latitude, :longitude,
                                   :url,
                                   :workday_opening_time,
                                   :sat_opening_time,
                                   :sun_opening_time,
                                   :orgnization,
                                   :sale_email,
                                   :sale_phone]
                                )
  end
  def user_param
    params.require(:user).permit(:name,
                   :zipcode,
                   :avatar,
                   :phone,
                   :group_name,
                   :number_of_group_members,
                   :university,
                   :wallet_link,
                   :billing_address)
  end
end
