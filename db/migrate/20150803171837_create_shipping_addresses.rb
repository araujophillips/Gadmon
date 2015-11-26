class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.boolean :office
      t.string :company
      t.string :address
      t.string :municipality
      t.string :city
      t.string :state
      t.string :comment

      t.timestamps null: false
    end
  end
end
