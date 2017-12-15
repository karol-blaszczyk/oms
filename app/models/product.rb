class Product < ApplicationRecord
  has_many :line_items

  validates :name, presence: true
  validates :net_price, numericality: { greater_than: 0 }
end
