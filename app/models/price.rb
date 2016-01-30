class Price < ActiveRecord::Base
	validates :price, numericality: { only_integer: true }

	belongs_to :product, foreign_key: :product_id
	has_many :order_details
end