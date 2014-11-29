require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  let(:user) { FactoryGirl.create(:user)}

  before do
    sign_in user
  end

  describe "GET new" do
    it "with a ticket count" do
      ticket = FactoryGirl.create(:ticket)
      get :new, order: {count: 6}, ticket_id: ticket.id
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do

    let(:ticket) {FactoryGirl.create(:ticket)}
    let(:post_order) {post :create, order: {count: 6,
             shipping_address_attributes: {first: 'abc', second: 'abc', zipcode: '11345', city: 'Flushing', state: 'NY'},
             billing_address_attributes: {first: 'abc', second: 'abc', zipcode: '11345', city: 'Flushing', state: 'NY'}
             }, ticket_id: ticket.id}

    it "get order amount price" do
      post_order
      amount = assigns(:order).amount
      expect(amount).to eq(120.0)
    end

    it "address should not be nil" do
      post_order
      assigns(:order).shipping_address.should_not be_nil
      assigns(:order).billing_address.should_not be_nil
    end


    it "wallet balance should decrease" do
      user.wallet.update(balance_in_cents: 100000)
      post_order
      user.reload
      user.wallet.balance.should == 1000 - 20 * 6
    end

    it "wallet balance not enough" do
      ticket.update( amount: 100)
      user.wallet.update(balance_in_cents: 10000)
      post_order
      user.reload
      user.wallet.balance.should == 100
      assigns(:order).status.should eq 'created'
    end

    it "ticket amount should decrease" do
      ticket.update(amount: 100)
      user.wallet.update(balance_in_cents: 100000)
      post_order
      ticket.reload
      ticket.amount.should == 94
    end

    it "should redirect to /mine/order" do
      user.wallet.update(balance_in_cents: 100000)
      post_order
      order_id = Order.first.id
      expect(response).to redirect_to mine_order_path(order_id)
    end

    it "order price should include shipping fee" do
      ticket.update(shipping_in_cents: 1000)
      post_order
      amount = assigns(:order).amount
      expect(amount).to eq(130.0)
    end

    it "order price should include student discount" do
      user_info = FactoryGirl.create(:student_info)
      user.user_info = user_info
      ticket.update(student_discount: 10)
      post_order
      amount = assigns(:order).amount
      expect(amount).to eq(20.0 * 0.9 * 6)
    end
  end
end
