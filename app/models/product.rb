class Product < ActiveRecord::Base
    validates :name, presence: true

	has_many :product_details, :dependent => :destroy
	has_many :prices, :dependent => :destroy
    has_many :order_details, :dependent => :destroy
	has_one :current_price, -> {
        where('prices.id = (SELECT MAX(id) FROM prices p2 WHERE product_id = prices.product_id)') 
    }, class_name: 'Price'

    accepts_nested_attributes_for :prices 
    accepts_nested_attributes_for :product_details

    def self.by_id(id)
      where("id = ?", id)
    end

    # It returns the products whose names contain one or more words that form the query
    def self.search(query)
        where(["products.name LIKE ?", "%#{query}%"])
    end

    def self.overview()
        includes(:current_price)
        .all
        .stock
        .order('id DESC')
    end

    # Returns a count with the available products on stock
    def self.stock()
        select('products.*, SUM(case when product_statuses.available=true then 1 else 0 end) as count')
        .joins('LEFT JOIN `product_details` `product_details` ON `product_details`.`product_id` = `products`.`id`')
        .joins('LEFT JOIN `product_statuses` ON `product_statuses`.`id` = `product_details`.`status`')
        .group('products.id')
    end

    # Returns a count with the available products on stock
    def self.only_with_stock()
        select('products.*, product_details.serial as serial')
        .joins(:product_details => :product_status)
        .where(:product_statuses => { :available => true })
        .group('products.id')
    end

    # Returns a list with product details availables on the inventory
    def product_details_availables
      ProductDetail.availables.by_id(self.id)
    end

end