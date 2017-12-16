class StatusTransactionsController < ApplicationController
  # GET /status_transactions/1
  def show
    render json: order.aasm(:status).events.map(&:name)
  end

  # POST /status_transactions
  def create
    event = status_transaction_params[:event]
    if order.aasm(:status).may_fire_event?(event.to_sym)
      order.public_send("#{event}!")
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  private

  # Get order
  def order
    @order ||= Order.find(params[:order_id])
  end

  # Only allow a trusted parameter "white list" through.
  def status_transaction_params
    params.require(:status_transaction).permit(:event)
  end
end
