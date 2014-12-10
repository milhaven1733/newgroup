module Mine
  class VoteMerchantsController < ApplicationController
    before_action :authenticate_user!
    
    def create
      @user = User.find_by(id: vote_merchant_params[:favorite_venue_id])
      if (current_user.id != @user) && !current_user.voted?(@user)
        current_user.vote!(@user)
      end
      respond_to do |format|
        format.html { redirect_to merchant_path(@user) }
        format.js
      end
    end
    
    def destroy
      @user = VoteMerchant.find(params[:id]).favorite_venue
      if current_user.voted?(@user)
        current_user.unvote!(@user)
      end
      respond_to do |format|
        format.html { redirect_to merchant_path(@user) }
        format.js
      end
    end
    
    private
    
    def vote_merchant_params
      params.require(:vote_merchant).permit(:favorite_venue_id)
    end
  end
end