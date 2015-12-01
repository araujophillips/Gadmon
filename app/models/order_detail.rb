class OrderDetail < ActiveRecord::Base
	belongs_to :order, foreign_key: :order_id
	belongs_to :product_detail, foreign_key: :product_detail_id

  	# accepts_nested_attributes_for :product_details
end