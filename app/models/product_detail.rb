class ProductDetail < ActiveRecord::Base
	belongs_to :product, foreign_key: :product_id
	belongs_to :product_status, foreign_key: :status
end