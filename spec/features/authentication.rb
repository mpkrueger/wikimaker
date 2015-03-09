require 'rails_helper'

feature "authentication" do
    
  

    scenario "user signs up" do
      visit root_path

      click_link 'Sign Up'
      fill_in 'Email', with: "matt@example.com"
      fill_in 'Password', with: "password"
      click_button "Sign up"

      expect(current_path).to eq user_registration_path

    end

    scenario "user signs in" do
      user = authenticated_user

      visit root_path
      click_link 'Sign In'
      fill_in 'Email', with: "matt@example.com"
      fill_in 'Password', with: "password"
      click_button "Sign in"

      expect( page ).to have_content("Welcome, Matt")
    end

  
end