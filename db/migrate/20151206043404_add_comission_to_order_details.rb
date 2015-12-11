class AddComissionToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :comission, :decimal
  end
end
