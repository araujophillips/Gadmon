class AddCustomerIdToShippingAddresses < ActiveRecord::Migration
  def change
    add_column :shipping_addresses, :customer_id, :integer
  end
end
