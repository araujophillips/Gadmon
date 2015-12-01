class RemoveDiscountFromOrderDetails < ActiveRecord::Migration
  def change
    remove_column :order_details, :discount, :decimal
  end
end
