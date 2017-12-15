class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.date :order_date
      t.float :vat, default: 0.2
      t.string :status
    end
  end
end
