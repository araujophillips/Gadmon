class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :provider_id
      t.decimal :subtotal
      t.decimal :tax
      t.decimal :total
      t.integer :invoice
      t.string :comment

      t.timestamps null: false
    end
  end
end
