require 'rails_helper'

RSpec.describe TicketsController, :type => :controller do
  let(:user) { FactoryGirl.create(:normal) }
  let(:ticket) { FactoryGirl.create(:ticket_with_group_prices) }

  before do
    sign_in user
  end

  describe "calc price action" do
    it "get @flat_price" do
      post :calc_price, id: ticket.id, count: 12, format: :js
      assigns(:flat_price).should eq 50
    end
  end
end
