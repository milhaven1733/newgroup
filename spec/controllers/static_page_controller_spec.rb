require 'rails_helper'

RSpec.describe StaticPageController, :type => :request do
	
	before do
		visit root_path
	end

	describe "about action" do
		context "when user click ABOUT US link" do
			it "show ABOUT US page" do
				click_on 'ABOUT US'
				page.has_content?('ABOUT US')
			end
		end	
	end

	describe "terms action" do
		context "when user click Terms of Service link" do
			it "show Terms of Service page" do
				click_on 'TERMS OF SERVICE'
				page.has_content?('Terms of Service')
			end
		end
	end	

	describe "privacy action" do
		context "when user click Privacy Policy link" do
			it "show Privacy Policy page" do
		  	click_on 'PRIVACY POLICY'
		  	page.has_content?('Privacy Policy')
			end
		end	
	end

	describe "faq action" do
		context "when user click FAQ link" do
			it "show FAQ page" do
				skip "To be implemented"
			end
		end	
	end
end
