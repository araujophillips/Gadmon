class Order < ActiveRecord::Base
	belongs_to :customer, foreign_key: :customer_id
	# has_many :order_details, :through => :order_details, :dependent => :destroy
	has_many :order_details, :dependent => :destroy
    accepts_nested_attributes_for :order_details

    def self.by_id(id)
    	where("id = ?", id)
    end

end