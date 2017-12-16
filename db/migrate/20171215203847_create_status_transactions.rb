class CreateStatusTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :status_transactions do |t|
      t.string :event
      t.string :from
      t.string :to
      t.date :created_at
      t.references :order, foreign_key: true

      t.datetime "created_at"
    end
  end
end
