require 'rails_helper'

feature "Recharges", :type => :feature do
	describe "User want to recharge" do
		context "When click 'recharge' button" do
			it "show input recharge money form" do
				visit "/mine/wallet"
				click_button 'Recharge'
				has_content? 'Pay with Card'
			end

			# Can't fill the form in modal
			it "show 'stripe' form" do
				skip "not write the test code casue can't fill the form in modal"
			end
		end
	end		
end
