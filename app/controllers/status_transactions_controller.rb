class StatusTransactionsController < ApplicationController
  before_action :set_status_transaction, only: [:show, :update, :destroy]

  # GET /status_transactions
  def index
    @status_transactions = StatusTransaction.all

    render json: @status_transactions
  end

  # GET /status_transactions/1
  def show
    render json: @status_transaction
  end

  # POST /status_transactions
  def create
    @status_transaction = StatusTransaction.new(status_transaction_params)

    if @status_transaction.save
      render json: @status_transaction, status: :created, location: @status_transaction
    else
      render json: @status_transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /status_transactions/1
  def update
    if @status_transaction.update(status_transaction_params)
      render json: @status_transaction
    else
      render json: @status_transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /status_transactions/1
  def destroy
    @status_transaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status_transaction
      @status_transaction = StatusTransaction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def status_transaction_params
      params.require(:status_transaction).permit(:event, :form, :to, :created_at, :order_id)
    end
end
