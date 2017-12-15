class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.integer :quantity
      t.decimal :net_price
      t.references :product, foreign_key: true, null: false
      t.references :order, foreign_key: true
    end
  end
end
