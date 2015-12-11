class Price < ActiveRecord::Base
	belongs_to :product, foreign_key: :product_id
	has_many :order_details
end