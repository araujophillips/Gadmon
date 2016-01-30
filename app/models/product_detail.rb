class ProductDetail < ActiveRecord::Base
	belongs_to :product, foreign_key: :product_id
	belongs_to :product_status, foreign_key: :status
	has_one :order_detail

	def self.by_id(id)
		where("product_id = ?", id)
	end

	def self.availables
		joins(:product_status)
    	.where(:product_statuses => { :available => true })
    end
end