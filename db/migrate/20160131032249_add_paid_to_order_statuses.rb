class AddPaidToOrderStatuses < ActiveRecord::Migration
  def change
    add_column :order_statuses, :paid, :boolean
  end
end
