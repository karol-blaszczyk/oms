class Order < ApplicationRecord
  include AASM

  has_many :line_items

  before_create { self.order_date = Date.today unless order_date.present? }

  validate :order_date_cannot_be_in_the_past

  def order_date_cannot_be_in_the_past
   if order_date && order_date < Date.today
     errors.add(:order_date, "can't be in the past")
   end
 end

 aasm(:status) do
  state :draft, :initial => true
  state :placed, :paid, :canceled

  event :place_order do
    transitions :from => :draft, :to => :placed
  end

  event :cancel do
    transitions :from => [:draft, :placed], :to => :canceled, :guard => :reason_provided?
  end

  event :pay_order do
    transitions :from => :palced, :to => :paid
  end
end

  def reason_provided?
    false
  end
end

# order cant change to the canceled status without a reason ?
#
# availabe update only if in status draft ?
