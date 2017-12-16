class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  before_create { self.net_price = product.net_price }

  validates_presence_of :product_id
  validates_presence_of :order_id
  validates :quantity, numericality: { greater_than: 0 }
  validate :order_status, on: :update

  # An line_item can only be edited while in the DRAFT status
  def order_status
    if order && !order.draft?
      errors.add(:order_status, 'An line_item can only be edited while in the DRAFT status')
    end
  end
end
