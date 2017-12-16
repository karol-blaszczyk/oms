class AddUniqIndexToProducts < ActiveRecord::Migration[5.1]
  def change
    add_index :products, %i[name net_price], unique: true
    add_index :products, :name, unique: true
  end
end
