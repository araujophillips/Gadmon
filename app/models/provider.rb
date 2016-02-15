class Provider < ActiveRecord::Base
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :phone, presence: true, numericality: true
	
	belongs_to :provider_type, foreign_key: :type_id
	has_many :purchases, :dependent => :destroy

	# It returns the customers whose names, emails or usernames contain one or more words that form the query
	def self.search(query)
	  	where(["name LIKE ? OR email LIKE ? OR phone LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%"])
	end
end
