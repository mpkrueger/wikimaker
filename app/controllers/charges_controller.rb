class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "WikiMaker Premium - #{current_user.name}",
      amount: 1000
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 1000,
      description: "WikiMaker Premium - #{current_user.email}",
      currency: 'usd'
    )

    flash[:success] = "Thanks for your payment, #{current_user.name}!"
    
    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

  end

end