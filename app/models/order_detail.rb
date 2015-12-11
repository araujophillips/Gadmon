class OrderDetail < ActiveRecord::Base
	belongs_to :order, foreign_key: :order_id
	belongs_to :product
	belongs_to :product_detail, foreign_key: :product_detail_id
	belongs_to :price

  	def self.by_order_id(order_id)
  		where("order_id = ?", order_id)
  	end
end