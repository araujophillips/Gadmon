class Customer < ActiveRecord::Base
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :phone, presence: true, numericality: true
	
	has_many :orders, :dependent => :destroy
	has_many :shipping_addresses, :dependent => :destroy

	# It returns the customers whose names, emails or usernames contain one or more words that form the query
	def self.search(query)
	  	where(["name LIKE ? OR email LIKE ? OR username LIKE ? OR phone LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%"])
	end
end