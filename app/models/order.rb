class Order < ActiveRecord::Base
	validates :subtotal, presence: true
	validates :comission, presence: true
	validates :tax, presence: true
	validates :total, presence: true

	belongs_to :customer, foreign_key: :customer_id
	has_many :order_details, :dependent => :destroy
	has_many :order_status_details, :dependent => :destroy

	has_attached_file :invoice_image, styles: { thumb: "570x400" }, :default_url => 'no-invoice.png'
	validates_attachment_content_type :invoice_image, content_type: /^image\/(jpg|jpeg|png)$/, :message => 'Por favor, utilice facturas en formato png, jpg o jpeg.'

    accepts_nested_attributes_for :order_details

	def self.search(query)
		where('orders.id = ? OR orders.invoice = ?', query, query)
	end

    def self.by_id(id)
    	where("id = ?", id)
    end

	def self.by_customer_id(customer_id)
		where("customer_id = ?", customer_id)
	end

    def self.with_current_status()
    	joins(order_status_details: :order_status)
    	.order('id DESC, order_status_details.created_at DESC')
    	.where('order_status_details.id IN (SELECT MAX(id) FROM order_status_details GROUP BY order_id)')
    	.select("orders.*, order_status_details.status_id, order_statuses.name, order_statuses.paid, order_status_details.created_at")
    end
end