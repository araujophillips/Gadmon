class OrderStatusDetail < ActiveRecord::Base
	belongs_to :order_status, foreign_key: :status_id
	belongs_to :order, foreign_key: :order_id

	def self.change_order_status(order)
		puts "Validando su hay que actualizar estado"
	end
end