class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items, dependent: :restrict_with_error

  validates :name, presence: true
  validates_uniqueness_of :name
  validates :net_price, numericality: { greater_than: 0 }
end
