class ChargesController < ApplicationController
  def new
  end
  def create
    
    #Amount is in cents
    @amount = 500

  # Creates a Stripe Customer object, for associating
  # with the charge
  customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
  )

  # Where the real magic happens
  charge = Stripe::Charge.create(
    customer: customer.id, # Note -- this is NOT the user_id in your app
    amount: @amount,
    description: "Blocipedia Membership - #{current_user.full_name}",
    currency: 'usd'
  )

  #current_user.role = "premium"
  #current_user.save

  flash[:notice] = "Your account has been upgraded to a premium account. You can now create private wikis and add collaborators."
  redirect_to wikis_path

# Stripe will send back CardErrors, with friendly messages
# when something goes wrong.
# This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_charge_path
  end
end
