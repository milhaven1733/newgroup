require 'rails_helper'

feature "SignUp", :type => :feature do
  describe "sign up a venue accout" do
    it "the status of new user should be unapproved" do
      visit new_user_registration_path
      within('#new_user') do
        fill_in 'user[email]', with: 'venue@test.com'
        fill_in 'user[name]', with: 'Venue'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        select 'venue', from: 'user[role]'
        click_button 'Sign up'
      end
      User.last.name.should eq 'Venue'
      User.last.merchant?.should eq false

      User.last.update!(verification: true)
      User.last.merchant?.should eq true
    end
  end
end
