class Order < ApplicationRecord
  include AASM

  has_many :line_items
  has_many :status_transactions

  before_create { self.order_date = Date.today unless order_date.present? }

  validate :order_date_cannot_be_in_the_past
  validate :order_status, on: :update

  aasm(:status) do
    state :draft, initial: true
    state :placed, :paid, :canceled

    after_all_transitions :log_status_change

    event :place_order do
      transitions from: :draft, to: :placed
    end

    event :cancel do
      transitions from: %i[draft placed], to: :canceled, guard: :reason_provided?
    end

    event :pay_order do
      transitions from: :palced, to: :paid
    end
  end

  # Order date cannot in the past
  # Validator method
  def order_date_cannot_be_in_the_past
    if order_date && order_date < Date.today
      errors.add(:order_date, "can't be in the past")
    end
  end

  # An line_item can only be edited while in the DRAFT status
  def order_status
    if draft?
      errors.add(:order_status, 'An order can only be edited while in the DRAFT status')
    end
  end

  # Create stauts transaciton for order
  def log_status_change
    status_transactions.create!(
      from: aasm(:status).from_state,
      to: aasm(:status).to_state,
      event: aasm(:status).current_event
    )
  end

  # Application requirements doens't specify what 'reason' means
  # Logic can be added here when such requiremnt will be provided
  def reason_provided?
    true
  end
end
