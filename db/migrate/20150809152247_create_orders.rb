class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.decimal :subtotal
      t.decimal :tax
      t.decimal :total
      t.integer :invoice
      t.integer :shipping_id

      t.timestamps null: false
    end
  end
end
