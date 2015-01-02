require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature "TicketSearches", :type => :feature do
  let(:user){FactoryGirl.create(:normal)}

  before do
    login_as user
  end

  describe "search by ticket price" do
    before do
      6.times.each_with_index do |i|
        ticket = FactoryGirl.create(:ticket_with_group_prices)
        ticket.update(oprice: 10 * i)
      end
    end

    it 'should success when given price range' do
      visit root_path
      within('#new_tickets_search') do
        fill_in 'tickets_search[oprice_gteq]', with: 20
        fill_in 'tickets_search[oprice_lteq]', with: 50
        click_button('Search Group Tickets')
      end
      count = 0
      Ticket.all.each { |ticket| count += 1 if ticket.flat_price <= 50 and ticket.flat_price >= 20 }
      page.should have_selector '.ticket', count: count
    end


    it 'should success when has one side price edge' do
      visit root_path
      within('#new_tickets_search') do
        fill_in 'tickets_search[oprice_gteq]', with: 20
        click_button('Search Group Tickets')
      end
      count = 0
      Ticket.all.each { |ticket| count += 1 if ticket.flat_price >= 20 }
      page.should have_selector '.ticket', count: count
    end

    it 'should success when has invalid price value' do
      visit root_path
      within('#new_tickets_search') do
        fill_in 'tickets_search[oprice_gteq]', with: 'abcd'
        click_button('Search Group Tickets')
      end
      page.should have_content 'Search Result'
      page.should_not have_selector '.ticket'
    end

    it "search result should include student's discounnt when user is a student" do
      user.user_info.update(is_student: true)
      visit root_path
      within('#new_tickets_search') do
        fill_in 'tickets_search[oprice_gteq]', with: 40
        fill_in 'tickets_search[oprice_lteq]', with: 80
        click_button('Search Group Tickets')
      end
      count = 0
      Ticket.all.each { |ticket| count += 1 if ticket.flat_price(5, true) >= 40 and ticket.flat_price(5, true) <= 80 }
    end
  end

  describe "search by ticket price" do
    before do
      6.times do |i|
        ticket = FactoryGirl.create(:ticket_with_group_prices)
        ticket.update(start_at: Date.new(2015, 01, 01) + i.days, end_at: Date.new(2015, 01, 01) + (i + 1).days)
      end
    end

    it "should search by date" do
      visit root_path
      within('#new_tickets_search') do
        fill_in 'tickets_search[time_tag_date_gteq]', with: '01/02/2015'
        fill_in 'tickets_search[time_tag_date_lteq]', with: '01/04/2015'
        click_button('Search Group Tickets')
      end
      page.should have_selector '.ticket', count: 3
    end

    it "should search by only start date" do
      visit root_path
      within('#new_tickets_search') do
        fill_in 'tickets_search[time_tag_date_gteq]', with: '01/04/2015'
        click_button('Search Group Tickets')
      end
      page.should have_selector '.ticket', count: 3

    end
  end
end
