class Order < ActiveRecord::Base
	belongs_to :customer, foreign_key: :customer_id
	has_many :order_details, :through => :order_details
    accepts_nested_attributes_for :order_details
end