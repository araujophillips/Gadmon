class ProductStatus < ActiveRecord::Base
	has_many :product_details
end