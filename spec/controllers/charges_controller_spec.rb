require 'rails_helper'

module ControllerHelpers
    def sign_in(user = double('user', email: 'abc@abc.com'))
      if user.nil?
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
        allow(controller).to receive(:current_user).and_return(nil)
      else
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end
    end
  end

class StripeStatus
  def status
    'succeeded'
  end
end

describe ChargesController do
  include Devise::TestHelpers
  include ControllerHelpers

  before do
    sign_in
  end

  describe "POST create" do
    it "creates a Stripe Customer" do
      allow(Stripe::Charge).to receive(:create).and_return(nil) # stub

      expect(Stripe::Customer).to receive(:create).with(email: 'abc@abc.com', card: "1234")
      post :create, stripeToken: '1234'
    end

    it "creates a Stripe Charge with customer information" do
      allow(Stripe::Customer).to receive(:create).and_return(nil) # stub

      expect(Stripe::Charge).to receive(:create).and_return double('charge', status: 'succeeded')
      post :create
    end
  end
end