require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "User and Merchant Vote Association" do
    let(:user){ FactoryGirl.create(:user) }
    let(:merchant){FactoryGirl.create(:merchant)}
    let(:merchant2){FactoryGirl.create(:merchant)}

    it "user can create favorite merchants" do
      user.favorite_merchants << merchant
      user.favorite_merchants << merchant2

      user.favorite_merchants.count.should eq 2
      user.favorite_merchant_votes.first.user_id.should eq user.id
      user.favorite_merchant_votes.first.favorite_merchant.should eq merchant
    end

    it "user can create both favorite merchants and tickets" do
      ticket = FactoryGirl.create(:ticket)
      user.favourites << ticket
      user.favourites.first.should eq ticket

      user.favorite_merchants << merchant
      user.favorite_merchants << merchant2
      user.favorite_merchants.count.should eq 2

      user.favourites.first.should eq ticket
    end
  end
end