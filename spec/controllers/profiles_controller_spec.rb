require 'rails_helper'

RSpec.describe ProfileController, :type => :controller do
  let(:user) { FactoryGirl.create(:user)}
  let(:merchant) { FactoryGirl.create(:merchant)}

  before do
    sign_in user
  end

  describe "favorite merchants" do
    it "user can save favorite merchant" do
      post :like, id: merchant.id
      user.favorite_merchants.should include(merchant)
    end

    it "user can not add normal user to favor merchant" do
    end
  end

end
