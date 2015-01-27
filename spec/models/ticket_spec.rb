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

  describe "search tickets by price range" do
    before :each do
      10.times.each_with_index do |i|
        ticket = FactoryGirl.create(:ticket_with_group_prices)
        ticket.update(oprice: 10 * i)
      end
    end
    it 'get tickets with given price range and count' do
      tickets = Ticket.search_by_price_range(30, 40, 20)
      puts 'TICKETS SEARCH RESULT TOTAL'
      p tickets.count
      tickets.each do |ticket|
        ticket.flat_price(20).should be_between(30.0, 40.0)
        ticket.flat_price(5).should_not be_between(30.0, 40.0)
      end

      tickets = Ticket.search_by_price_range(60, 70, 10)
      puts 'TICKETS SEARCH RESULT TOTAL'
      p tickets.count
      tickets.each { |ticket| ticket.flat_price(10).should be_between(50.0, 70.0) }
    end

    it 'get student discount tickets with given price range and count' do
      tickets = Ticket.search_by_price_range(30, 40, 20, true)
      puts 'TICKETS SEARCH RESULT TOTAL'
      p tickets.count
      tickets.each { |ticket| ticket.flat_price(20, true).should be_between(30.0, 40.0) }
    end

    it 'should search sucess when only has one price edge' do
      tickets = Ticket.search_by_price_range(30, nil, nil)
      puts 'TICKETS SEARCH RESULT TOTAL'
      p tickets.count
      tickets.each { |ticket| ticket.flat_price.should >= 30 }

      tickets = Ticket.search_by_price_range(nil, 50, nil)
      puts 'TICKETS SEARCH RESULT TOTAL'
      p tickets.count
      tickets.each { |ticket| ticket.flat_price.should <= 50 }
    end
  end

  describe "search by price range with none group_prices tickets" do
    before :each do
      10.times.each_with_index do |i|
        ticket = FactoryGirl.create(:ticket)
        ticket.update(oprice: 10 * i)
      end
      10.times.each_with_index do |i|
        ticket = FactoryGirl.create(:ticket_with_group_prices)
        ticket.update(oprice: 10 * i)
      end
    end

    it "should get result within both none and group prices tickets" do
      tickets = Ticket.search_by_price_range(30, 50, 10)
      tickets.each { |ticket| ticket.oprice.should be_between(30, 50) unless ticket.group_prices.present? }
      tickets.each { |ticket| ticket.flat_price(10).should be_between(30, 50) }
    end
  end
end
