require 'rails_helper'

describe "wikis" do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = TestFactories.authenticated_user
    @wiki = TestFactories.associated_wiki
    login_as(@user, :scope => :user)
  end

  after do
    Warden.test_reset!
  end

  feature "index" do

    scenario "user sees all of the public wikis" do

      visit wikis_path
      expect( page ).to have_content(@wiki.title)

    end

  end

  feature "new" do

    scenario "user creates a new wiki" do
      visit new_wiki_path

      fill_in 'Title', with: 'Wiki title'
      fill_in 'Body', with: 'This wiki is awesome.'
      click_button "Save"

      expect{
        (current_path).to eq wikis_path
        (Wiki.count).to change by 1
      }
    end

  end

  feature "edit" do

    scenario "user edits an existing wiki" do
      visit wiki_path(@wiki.id)

      click_link "Edit Wiki"
      fill_in 'Title', with: 'New Title'
      fill_in 'Body', with: 'An even better wiki.'
      click_button "Save"

      expect( page ).to have_content("New Title")
    end
  end

  feature "delete" do

    scenario "user delets an existing wiki" do
      visit wiki_path(@wiki.id)

      click_link "Delete Wiki"

      expect{
        (current_path).to eq wikis_path
        (Wiki.count).to change by -1
      }
    end
  end

end