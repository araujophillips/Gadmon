class ShippingAddress < ActiveRecord::Base
	belongs_to :customer, foreign_key: :customer_id
end