class MineController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: false

  def profile
    @favourite_tickets = current_user.favourites
  end

  def update_profile
    final_param = current_user.merchant? ? merchant_param : user_param

    if current_user.update(final_param)
      respond_to do |format|
        format.html { redirect_to action: :profile }
        format.mobile { redirect_to mine_edit_profile_path }
      end 
    else
      render :edit_profile
    end
  end
  
  def edit_profile
    if current_user.merchant?
      @merchant_info = current_user.merchant_info || MerchantInfo.new(user_id: current_user.id)
      @address = @merchant_info.address || @merchant_info.build_address
    else
      @user_info = current_user.user_info || UserInfo.new(user_id: current_user.id)
      @address = @user_info.address || @user_info.build_address
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
                                  :phone,
                                  :url,
                                  :workday_opening_time,
                                  :sat_opening_time,
                                  :sun_opening_time,
                                  :orgnization,
                                  :sales_email,
                                  :sales_phone,
                                  address_attributes: [:first,
                                                       :second,
                                                       :city,
                                                       :state,
                                                       :zipcode]
                                 ]
                               )
  end
  def user_param
    params.require(:user).permit(:name,
                                 :avatar,
                                 :email,
                                 user_info_attributes: [
                                   :zipcode,
                                   :phone,
                                   :group_name,
                                   :number_of_group_members,
                                   :university,
                                   :wallet_link,
                                   :billing_address,
                                   address_attributes: [:first,
                                                        :second,
                                                        :city,
                                                        :state,
                                                        :zipcode]
                                 ]
                                )
  end
end
