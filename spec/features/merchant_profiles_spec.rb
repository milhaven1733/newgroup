require 'rails_helper'

feature "MerchantProfiles", :type => :feature do
  let(:merchant){FactoryGirl.create(:merchant)}

  describe "more tickets" do
    before :each do
      10.times.each { |i| FactoryGirl.create(:ticket) }
    end

    it "should have a show more button" do
      visit merchant_path(merchant)
      page.should have_content 'More>>'
      page.should have_selector '.ticket', count: 6
    end

    it "click button should show more tickets", js: true do
      visit merchant_path(merchant)
      find_link('More>>').click
      page.should_not have_content 'More>>'
      page.should have_selector '.ticket', count: 10
    end
  end
end
