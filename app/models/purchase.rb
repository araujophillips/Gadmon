class Purchase < ActiveRecord::Base
	has_many :purchase_details, :dependent => :destroy
	belongs_to :provider, foreign_key: :provider_id

	has_attached_file :invoice_image, styles: { thumb: "570x400" }, :default_url => 'no-invoice.png'
	validates_attachment_content_type :invoice_image, content_type: /^image\/(jpg|jpeg|png)$/, :message => 'Por favor, utilice facturas en formato png, jpg o jpeg.'

	# It returns the purchases where ID or invoice be equal to search
	def self.search(query)
	  	where('purchases.id = ? OR purchases.invoice = ?', query, query)
	end
end
