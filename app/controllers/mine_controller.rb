class MineController < ApplicationController

  def profile
    @favourite_tickets = current_user.favourites
  end

  def update_profile
    final_param = current_user.merchant? ? merchant_param : user_param
    if current_user.update(final_param)
      redirect_to action: :profile
    else
      render mine_edit_profile_path, error: current_user.errors.full_messages.join(', ')
    end
  end
  
  def edit_profile
    if current_user.merchant?
      @merchant_info = current_user.merchant_info || MerchantInfo.new(user_id: current_user.id)
		else
			@user_info = current_user.user_info || UserInfo.new(user_id: current_user.id)
    end
  end

  private

  def merchant_param
    params.require(:user).permit(:name,
																 :email,
                                 :avatar,
                                 merchant_info_attributes:
                                   [:latitude, :longitude,
																	 :category_id,
																	 :address,
                                   :phone,
                                   :url,
                                   :workday_opening_time,
                                   :sat_opening_time,
                                   :sun_opening_time,
                                   :orgnization,
                                   :sales_email,
                                   :sales_phone]
                                )
  end
  def user_param
    params.require(:user).permit(:name,
                   :avatar,
                   :email,
                   user_info_attributes:[
                   :zipcode,
                   :address,
                   :phone,
                   :group_name,
                   :number_of_group_members,
                   :university,
                   :wallet_link,
                   :billing_address]
                  )
  end
end