class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "WikiMaker Premium - #{current_user.name}",
      amount: Amount.default
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
  #     customer: customer.id,
  #     amount: Amount.default,
  #     description: "WikiMaker Premium - #{current_user.email}",
  #     currency: 'usd'
    )
  #   if charge.status == "succeeded"
  #     current_user.role = "premium"
  #     current_user.save!
  #   end

  #   flash[:success] = "Thanks for your payment, #{current_user.name}!"
    
  #   redirect_to root_path

  head :ok

  #   # not sure why this works... rescue - doesn't need an 'end'?
  # rescue Stripe::CardError => e
  #   flash[:error] = e.message
  #   redirect_to new_charge_path

  end

end