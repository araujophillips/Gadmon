class OrderStatus < ActiveRecord::Base
	has_many :order_status_details
end
