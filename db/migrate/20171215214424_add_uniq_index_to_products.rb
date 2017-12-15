class AddUniqIndexToProducts < ActiveRecord::Migration[5.1]
  def change
    add_index :products, [:name, :net_price], unique: true
  end
end
