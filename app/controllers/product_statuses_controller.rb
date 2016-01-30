class ProductStatusesController < ApplicationController
	def list
		@product_statuses = ProductStatus.all
	end
end