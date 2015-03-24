require 'rails_helper'

describe ChargesController do
  include Devise::TestHelpers
  include ControllerHelpers

  let(:current_user) { TestFactories.authenticated_standard email: 'abc@abc.com'}

  before do
    sign_in current_user
  end

  describe "POST create" do
    it "creates a Stripe Customer" do
      customer = double('customer', id: 1)

      allow(Stripe::Charge).to receive(:create).and_return(double('charge', status: 'succeeded')) # stub

      expect(Stripe::Customer).to receive(:create).with(email: 'abc@abc.com', card: "1234").and_return(customer)
      post :create, stripeToken: '1234'
    end

    it "creates a Stripe Charge with customer information" do
      customer = double('customer', id: 1)
      allow(Stripe::Customer).to receive(:create).and_return(customer) # stub

      expect(Stripe::Charge).to receive(:create).with(customer: 1,
                                                      amount: Amount.default,
                                                      description: "WikiMaker Premium - abc@abc.com",
                                                      currency: 'usd').and_return(double('charge', status: 'succeeded'))
      post :create
    end

    context "when the charge succeeds" do
      before do
        customer = double('customer', id: 1)
        allow(Stripe::Customer).to receive(:create).and_return(customer) # stub

        allow(Stripe::Charge).to receive(:create).with(customer: 1,
                                                       amount: Amount.default,
                                                       description: "WikiMaker Premium - abc@abc.com",
                                                       currency: 'usd').and_return(double('charge', status: 'succeeded'))
      end
      
      it "updates user's role to premium" do
        expect(current_user.reload.role).to eq('standard')
        post :create
        expect(current_user.reload.role).to eq('premium')
      end

    end

  end
end