require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature "Tickets" do
  let(:user){FactoryGirl.create(:user)}
  let(:ticket){FactoryGirl.create(:category); FactoryGirl.create(:ticket_with_group_prices)}

  before do
    login_as user
  end

  describe 'ticket show page' do
    it "show price when user input a valid count", js: true do
      visit ticket_path(ticket)
      page.should have_content '$100'
      fill_in 'order[count]', with: '6'
      page.should have_content '$' + (70 * 6).to_s
    end

    it "show different price when user input a different count", js: true do
      visit ticket_path(ticket)
      fill_in 'order[count]', with: '20'
      page.should have_content '$' + (50 * 20).to_s
    end

    it "checkout button should be disabled when user input invalid count", js: true do
      visit ticket_path(ticket)
      fill_in 'order[count]', with: '1000'
      find('#total-price').value.should be_nil
    end
  end
end