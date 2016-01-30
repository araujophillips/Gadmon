class ShippingAddress < ActiveRecord::Base
	validates :address, presence: true
	validates :state, presence: true
	validates :city, presence: true
	
	belongs_to :customer, foreign_key: :customer_id
end