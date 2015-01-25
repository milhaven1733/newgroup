module Mine
  class WalletsController < ApplicationController
    before_action :authenticate_user!
    authorize_resource class: false

    def show
    end

    def recharge
      customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        card: params[:stripeToken]
      )

      @transaction = Transaction.new(dollar: transaction_param[:recharge],
                                     user: current_user,
                                     transaction_type: :recharge,
                                     token: params[:stripeToken],
                                     customer_id: customer.id)

      Stripe::Charge.create(
        customer: customer.id,
        amount: @transaction.dollar_in_cents,
        description: 'Recharge to GroupEt Account',
        currency: 'usd'
      )

      @transaction.status = :success
      @transaction.save!

      redirect_to mine_wallet_path, notice: 'Recharge Success'
    rescue Stripe::CardError => e
      redirect_to mine_wallet_path, error: e.message
    rescue ActiveRecord::RecordNotSaved
      redirect_to mine_wallet_path, error: @transaction.errors.full_messages.join(' ')
    end

    def withdraw
    end

    private

    def transaction_param
      params.permit!
    end
  end
end
