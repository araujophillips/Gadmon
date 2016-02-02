class OrderStatusDetail < ActiveRecord::Base
	belongs_to :order_status, foreign_key: :status_id
	belongs_to :order, foreign_key: :order_id

	def self.change_order_status(order, order_status)
		@order_status_details = OrderStatusDetail.where('order_id = ?', order.id)
		if @order_status_details.last.status_id.to_i != order_status.to_i
			@current_status = OrderStatusDetail.create(:status_id => order_status,:order_id => order.id)
		end
	end
end