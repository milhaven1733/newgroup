require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature "Orders", :type => :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:ticket){FactoryGirl.create(:category); FactoryGirl.create(:ticket_with_group_prices)}

  before do
    login_as user, scope: :user
  end

  describe "order new page" do
    it "show checkout page should success" do
      visit new_ticket_order_path(ticket)
      page.should have_content('CHECK OUT')
    end

    it "should show right total price" do
      visit new_ticket_order_path(ticket, order: {count: 6})
      page.should have_content '$420'

      visit new_ticket_order_path(ticket, order: {count: 20})
      page.should have_content '$1000'
    end
  end
end
