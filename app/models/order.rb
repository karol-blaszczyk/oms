class Order < ApplicationRecord
  include AASM

  has_many :line_items
  has_many :status_transactions

  before_create { self.order_date = Date.today unless order_date.present? }

  validate :order_date_cannot_be_in_the_past
  validate :order_status, on: :update

  def order_date_cannot_be_in_the_past
   if order_date && order_date < Date.today
     errors.add(:order_date, "can't be in the past")
   end
  end

   # An line_item can only be edited while in the DRAFT status
   def order_status
     if order && !order.draft?
       errors.add(:order_status, "An order can only be edited while in the DRAFT status")
     end
   end

   aasm(:status) do
    state :draft, :initial => true
    state :placed, :paid, :canceled

    after_all_transitions :log_status_change

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

  # Create stauts transaciton for order
  def log_status_change
    status_transactions.create!(
      from: aasm.from_state,
      to: aasm.to_state,
      event: aasm.current_event
    )
  end

  # Application requirements doens't specify what 'reason' means
  # Logic can be added here when such requiremnt will be provided
  def reason_provided?
    true
  end
end
