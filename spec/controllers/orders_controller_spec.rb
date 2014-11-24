require 'rails_helper'
require 'support/utilyties'

RSpec.describe OrdersController, :type => :controller do
  before "log in" do
    merchant = create(:user, role: :merchant)
    log_in(merchant)
  end
  
  describe "GET #index" do
    it "should have content 'Order Listing" do
      visit mine_orders_path
      expect(page).to have_content('Order Listing')
    end
  end
end
