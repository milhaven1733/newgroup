require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature "Mine Tickets" do
  describe 'Create new ticket' do
    describe 'Only merchants users can visit' do

      it 'should ask for logging in' do
        visit "/mine/tickets/new"
        expect(page).to have_text("Please sign in")
      end

      it 'should redirect to home page when users do not belongs to merchants' do
        user = FactoryGirl.create(:user) 
        login_as user, scope: :user

        visit "/mine/tickets/new"
        expect(page).to have_text('Top Deals in Your City')
      end      
    end

    describe 'Merchants can create new ticket' do

      before do
        merchant = FactoryGirl.create(:merchant)
        login_as merchant, scope: :user
        Category.create(name: 'Ballet')
      end

      it 'should create a new ticket', js: true do
        visit "/mine/tickets/new"

        within("#new_ticket") do
          select "NewYork", from: "ticket[city]"
          select("Ballet", from: 'ticket[category_id]')
          fill_in "ticket_name", with: "Ticket Name"
          fill_in "ticket_desc", with: "Description"
          fill_in "ticket[start_at]", with: "2014/12/15 20:00"
          fill_in "ticket[end_at]", with: "2014/12/15 21:00"
          fill_in "ticket[amount]", with: 500
          fill_in "ticket[minimum_amount]", with: 10
          fill_in "ticket[oprice]", with: 1000
          find('#has-student-discount').trigger('click')
          find('#ticket_student_discount').set('10')
          find('#ticket_shipping').set('10.0')
          find('#ticket_will_call').trigger('click')

          click_button "UPLOAD TICKET LISTING"
        end
        expect(page).to have_content("successfully")
      end
    end

    describe "Add price tier" do
      let(:merchant){FactoryGirl.create(:merchant)}

      before do
        Category.create(name: 'Ballet')
        login_as merchant, scope: :user
      end

      it "add price tier should success" do
        ticket = FactoryGirl.create(:ticket)
        ticket.update(user: merchant)
        visit "/mine/tickets/#{ticket.id}"
        page.should have_content 'Add Group Price'
        find_link('Add Group Price').click
        page.should have_content 'Add group price for'
        find('input[name="group_price[range_from]"]').set(10)
        find('input[name="group_price[range_to]"]').set(20)
        find('input[name="group_price[discount]"]').set(20)
        click_button('Create Group price')
        page.should have_content '10-20'
      end
    end
  end
end