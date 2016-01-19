class OrderDetail < ActiveRecord::Base
	belongs_to :order, foreign_key: :order_id
	belongs_to :product
	belongs_to :product_detail, foreign_key: :product_detail_id
	belongs_to :price

  	before_destroy :set_detail_as_available

  	def self.by_order_id(order_id)
  		where("order_id = ?", order_id)
  	end

    def set_detail_as_available
    	order_details = order.order_details

    	order_details.each do |order_detail|
    		ProductDetail.update(order_detail.product_detail_id, :status => 1)
    	end
    end
end