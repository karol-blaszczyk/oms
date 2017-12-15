class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates_presence_of :product_id
  validates :quantity, numericality: { greater_than: 0 }
  validate :net_price_of_product

  def net_price_of_product
    if self.net_price != product&.net_price
      errors.add(:net_price, "net_price must equal product net_price")
    end
 end
end
