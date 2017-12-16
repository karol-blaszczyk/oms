class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :update, :destroy]

  # GET /line_items
  def index
    @line_items = order.line_items

    render json: @line_items
  end

  # GET /line_items/1
  def show
    render json: @line_item
  end

  # POST /line_items
  def create
    @line_item = order.line_items.new(line_item_params)

    if @line_item.save
      render json: @line_item, status: :created, location: @line_item
    else
      render json: @line_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /line_items/1
  def update
    if @line_item.update(line_item_params)
      render json: @line_item
    else
      render json: @line_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /line_items/1
  def destroy
    @line_item.destroy
  end

  private

    # Get order
    def order
      @order ||= Order.find(line_item_params[:order_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = order.line_items.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def line_item_params
      params.require(:line_item).permit(:quantity, :net_price, :product_id, :order_id)
    end
end
