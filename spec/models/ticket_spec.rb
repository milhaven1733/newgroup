require 'rails_helper'

RSpec.describe Ticket, :type => :model do
  describe "get ticket price by count" do
    let(:ticket) {FactoryGirl.create(:ticket)}
    let(:group_price) {FactoryGirl.create(:group_price)}
    let(:group_price2) {FactoryGirl.create(:group_price2)}
    before :each do
      ticket.group_prices << [group_price, group_price2]
    end

    it "get flat_price by different tickets quantity" do
      ticket.flat_price(5).should eq 70
      ticket.flat_price(12).should eq 50
    end

    it "get discount by different tickets quantity" do
      ticket.flat_discount(5).should eq 30
      ticket.flat_discount(12).should eq 50
    end

    it "get flat_price and flat_discount for student" do
      ticket.flat_price(5, true).should eq 60
      ticket.flat_price(12, true).should eq 40
      ticket.flat_discount(5, true).should eq 40
      ticket.flat_discount(12, true).should eq 60
    end
  end
end
