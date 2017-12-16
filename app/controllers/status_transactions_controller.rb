class StatusTransactionsController < ApplicationController
  before_action :set_status_transaction, only: [:show, :update, :destroy]

  # GET /status_transactions/1
  def show
    render json: @order.aasm(:status).events.map(&:name)
  end

  # POST /status_transactions
  def create
    state_machine = order.aasm(:status)
    event = status_transaction_params[:event]
    if state_machine.may_fire_event?(event)
      state_machine.send(event)
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  private

    # Get order
    def order
      @order ||= order.find(line_item_params[:order_id])
    end

    # Only allow a trusted parameter "white list" through.
    def status_transaction_params
      params.require(:status_transaction).permit(:event)
    end
end
