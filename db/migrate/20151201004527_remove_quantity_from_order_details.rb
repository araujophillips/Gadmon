class RemoveQuantityFromOrderDetails < ActiveRecord::Migration
  def change
    remove_column :order_details, :quantity, :int
  end
end
