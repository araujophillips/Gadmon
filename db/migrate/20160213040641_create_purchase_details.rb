class CreatePurchaseDetails < ActiveRecord::Migration
  def change
    create_table :purchase_details do |t|
      t.integer :purchase_id
      t.integer :line
      t.string :name
      t.decimal :price

      t.timestamps null: false
    end
  end
end
