class AddProductDetailIdToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :product_detail_id, :int
  end
end
