class Order < ActiveRecord::Base
	belongs_to :customer, foreign_key: :customer_id
	has_many :order_details
end