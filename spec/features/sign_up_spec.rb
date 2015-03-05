require 'rails_helper'

describe "Sign up flow" do

  describe "successful" do
    
    it "takes a valid email address" do
      visit root_path

      click_link 'Sign Up'
      fill_in 'Email', with: "matt@example.com"
      fill_in 'Password', with: "password"
      click_button "Sign up"

      expect(current_path).to eq user_registration_path

    end

    
  end
  
end