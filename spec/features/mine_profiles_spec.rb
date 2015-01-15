require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature "MineProfiles", :type => :feature do
  let(:user) { FactoryGirl.create(:normal) }

	before do
	  login_as user, scope: :user
		visit mine_profile_path
	end

	describe "mine profile page" do
		it "has content 'Profile'" do
			has_content? "Profile"
		end	

		context "when click 'glyphicon-eye-open'" do
			it "show Edit Profile page" do
				find('.glyphicon-eye-open').click
				has_content? user.name
			end
		end

		context "when click 'glyphicon-edit'" do
			it "show User page" do
				find('.glyphicon-edit').click
				has_content? "Edit Profile"
			end
		end
	end
end
