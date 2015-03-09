require 'rails_helper'

feature "authentication" do
    
    scenario "user signs up" do
      visit root_path

      within ".user-info" do
        click_link 'Sign Up'
      end
      fill_in 'Email', with: "matt@example.com"
      fill_in 'Password', with: "password"
      click_button "Sign up"

      expect(current_path).to eq user_registration_path

    end

    scenario "user signs in" do
      user = TestFactories.authenticated_user email: "matt@example.com"

      visit root_path
      within ".user-info" do
        click_link 'Sign In'
      end
      fill_in 'Email', with: "matt@example.com"
      fill_in 'Password', with: "password"
      click_button "Sign in"

      expect( page ).to have_content("Hello Matt")
    end

  
end