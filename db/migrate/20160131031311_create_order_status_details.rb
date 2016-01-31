class CreateOrderStatusDetails < ActiveRecord::Migration
  def change
    create_table :order_status_details do |t|
      t.integer :status_id

      t.timestamps null: false
    end
  end
end
