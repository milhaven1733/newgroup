require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature "Profiles", :type => :feature do
  let(:user) { FactoryGirl.create(:normal) }
  let(:merchant) { FactoryGirl.create(:merchant) }

  before do
    login_as user, scope: :user
  end

  describe 'favorite merchant' do
    it "should has favor merchant link" do
      visit merchant_path(merchant)
      page.should have_selector(".glyphicon-star-empty")
    end

    it "could click favor merchant link", js: true do
      visit merchant_path(merchant)
      find('.button-as-link').trigger(:click)
      wait_for_ajax
      page.should have_selector('.glyphicon-star')

      find('.button-as-link').trigger(:click)
      wait_for_ajax
      page.should have_selector('.glyphicon-star-empty')
    end

    it "user profile not have favor button" do
      visit user_path(user)
      page.should_not have_selector(".glyphicon-star-empty")
    end
  end

  describe "address info on profile page" do
    it "profile page has user address" do
      user.user_info.address.update(zipcode: '10000', first: '12 21Street')
      visit mine_profile_path
      page.should have_content '10000'
      page.should have_content '12 21Street'
      visit user_path(user)
      page.should have_content '10000'
      page.should have_content '12 21Street'
    end

    it "merchant profile page should has address" do
      merchant = FactoryGirl.create(:merchant)
      merchant.merchant_info.address.update(zipcode: '10000', first: '12 21Street')
      visit merchant_path(merchant)
      page.should have_content '10000'
      page.should have_content '12 21Street'
    end
  end
end
