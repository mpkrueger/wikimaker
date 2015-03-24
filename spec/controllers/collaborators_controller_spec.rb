require 'rails_helper'

describe CollaboratorsController do
  include Devise::TestHelpers
  include ControllerHelpers

  let(:current_user) { TestFactories.authenticated_standard email: 'abc@abc.com'}

  before do
    sign_in current_user
  end

  describe "POST create" do
    it "creates a new collaborator with correct user_id and wiki_id" do
      @wiki = TestFactories.associated_wiki

      expect{
        post( :create, user: current_user.id, wiki_id: @wiki.id )
      }.to change{ @wiki.collaborators.count }.by 1
    end

  end

  describe "DELETE destroy" do
    it "removes a collaborator from the wiki" do
      @wiki = TestFactories.associated_wiki
      collaborator = @wiki.collaborators.create!(user_id: current_user.id, wiki_id: @wiki.id)

      expect{
        delete( :destroy, wiki_id: @wiki.id, id: collaborator.id )
      }.to change{ @wiki.collaborators.count }.by -1
    end
  end
end