class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates_presence_of :product_id
  validates :quantity, numericality: { greater_than: 0 }
  validate :net_price_of_product

  before_create { self.net_price = self.product.net_price }
end
