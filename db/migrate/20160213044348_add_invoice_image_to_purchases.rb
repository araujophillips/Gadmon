class AddInvoiceImageToPurchases < ActiveRecord::Migration
  def change
  	add_attachment :purchases,:invoice_image
  end
end