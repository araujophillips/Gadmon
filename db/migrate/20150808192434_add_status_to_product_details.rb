class AddStatusToProductDetails < ActiveRecord::Migration
  def change
    add_column :product_details, :status, :integer
  end
end
