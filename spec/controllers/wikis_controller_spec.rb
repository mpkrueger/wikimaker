require 'rails_helper'

describe WikisController do
  include Devise::TestHelpers
  include ControllerHelpers

  let(:current_user) { TestFactories.authenticated_standard email: 'abc@abc.com'}

  before do
    sign_in current_user
  end

  describe "POST create" do

    it "creates a new wiki" do
      params = { :wiki => { title: "A new wiki", body: "A great wiki body." } }

      expect{
        post( :create, params )
      }.to change{ Wiki.count }.by 1
    end
  end

  describe "PATCH update" do

    it "updates an existing wiki" do
      wiki = TestFactories.associated_wiki
      params = { id: wiki.id, :wiki => { title: "A new title", body: "A new body." } }

      patch :update, params
      expect(wiki.reload.title).to eq 'A new title'

    end

  end

  describe "DELETE destroy" do
    
    it "deletes an existing wiki" do
      wiki = TestFactories.associated_wiki
      expect{
        delete( :destroy, id: wiki.id )
      }.to change{ Wiki.count }.by -1
    end

  end
end