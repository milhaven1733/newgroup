require 'rails_helper'

RSpec.describe ProfileController, :type => :controller do
  let(:user) { FactoryGirl.create(:user)}
  let(:merchant) { FactoryGirl.create(:merchant)}
  let(:merchant1) { FactoryGirl.create(:merchant)}

  before do
    sign_in user
  end

  describe "favorite merchants" do
    it "user can save favorite merchant" do
      post :like, id: merchant.id, format: :js
      user.favorite_merchants.should include(merchant)
    end

    it "user profile show saved favorite merchants" do
      post :like, id: merchant.id, format: :js
      post :like, id: merchant1.id, format: :js
      xhr :get, :user, id: user.id
      assigns(:favorite_venues).should match_array [merchant, merchant1]
    end
  end

end
