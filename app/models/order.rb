class Order < ApplicationRecord
  has_many :line_items

  before_create { self.order_date = Date.today unless order_date.present }

  validate :order_date_cannot_be_in_the_past

  def order_date_cannot_be_in_the_past
   if order_date.present? && order_date < Date.today
     errors.add(:order_date, "can't be in the past")
   end
 end
end
