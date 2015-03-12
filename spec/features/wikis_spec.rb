require 'rails_helper'

describe "wikis" do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @admin = TestFactories.authenticated_admin
    @standard = TestFactories.authenticated_standard
    @premium = TestFactories.authenticated_premium
    @public_wiki = TestFactories.associated_wiki
    @private_wiki = TestFactories.associated_wiki private: true
  end

  after do
    Warden.test_reset!
  end

  feature "index" do

    scenario "admin sees all of the public wikis" do
      login_as(@admin, :scope => :user)
      visit wikis_path
      expect( page ).to have_content(@public_wiki.title)

    end

    scenario "standard user sees all of the public wikis" do
      login_as(@standard, :scope => :user)
      visit wikis_path
      expect( page ).to have_content(@public_wiki.title)
    end

    scenario "standard user shouldn't see private wikis" do
      login_as(@standard, :scope => :user)
      visit wikis_path
      expect( page ).to_not have_content(@private_wiki.title)
    end

  end

  feature "show" do
    scenario "standard user shouldn't see private wiki" do
      login_as(@standard, :scope => :user)
      visit wiki_path(@private_wiki.id)
      expect( page ).to have_content("You're not authorized")
    end
  end

  feature "new" do

    scenario "admin creates a new public wiki" do
      login_as(@admin, :scope => :user)
      visit new_wiki_path

      fill_in 'Title', with: 'Wiki title'
      fill_in 'Body', with: 'This wiki is awesome.'
      click_button "Save"

      expect{
        (current_path).to eq wikis_path
        (Wiki.count).to change by 1
      }
    end

    scenario "standard user creates a new public wiki" do
      login_as(@standard, :scope => :user)
      visit new_wiki_path

      fill_in 'Title', with: 'Wiki title'
      fill_in 'Body', with: 'This wiki is awesome.'
      click_button "Save"

      expect{
        (current_path).to eq wikis_path
        (Wiki.count).to change by 1
      }
    end

    scenario "premium user creates a new public wiki" do
      login_as(@premium, :scope => :user)
      visit new_wiki_path

      fill_in 'Title', with: 'Wiki title'
      fill_in 'Body', with: 'This wiki is awesome.'
      click_button "Save"

      expect{
        (current_path).to eq wikis_path
        (Wiki.count).to change by 1
      }
    end

    scenario "premium user creates a new private wiki" do
      login_as(@premium, :scope => :user)
      visit new_wiki_path

      fill_in 'Title', with: 'Wiki title'
      fill_in 'Body', with: 'This wiki is awesome.'
      check "Private"
      click_button "Save"

      expect{
        (current_path).to eq wikis_path
        (Wiki.last.private == true)
        (Wiki.count).to change by 1
      }
    end

    scenario "standard user shouldn't be able to create a new private wiki" do
      login_as(@standard, :scope => :user)
      visit new_wiki_path

      expect( page ).to_not have_content("Private wiki")
    end

  end

  feature "edit" do

    scenario "user edits an existing wiki" do
      login_as(@admin, :scope => :user)
      visit wiki_path(@public_wiki.id)

      click_link "Edit Wiki"
      fill_in 'Title', with: 'New Title'
      fill_in 'Body', with: 'An even better wiki.'
      click_button "Save"

      expect( page ).to have_content("New Title")
    end
  end

  feature "delete" do

    scenario "user delets an existing wiki" do
      login_as(@admin, :scope => :user)
      visit wiki_path(@public_wiki.id)

      click_link "Delete Wiki"

      expect{
        (current_path).to eq wikis_path
        (Wiki.count).to change by -1
      }
    end
  end

end