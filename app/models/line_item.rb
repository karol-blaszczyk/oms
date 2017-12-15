class LineItem < ApplicationRecord
  belongs_to :product, presence: true
  belongs_to :order
end
