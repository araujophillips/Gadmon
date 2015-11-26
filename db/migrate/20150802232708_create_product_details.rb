class CreateProductDetails < ActiveRecord::Migration
  def change
    create_table :product_details do |t|
      t.integer :product_id
      t.string :serial
      t.string :comment

      t.timestamps null: false
    end
  end
end
