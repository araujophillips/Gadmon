class AddComissionToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :comission, :decimal
  end
end
