class AddOrderIdToOrderStatusDetails < ActiveRecord::Migration
  def change
    add_column :order_status_details, :order_id, :integer
  end
end
