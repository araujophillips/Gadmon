class AddInvoiceImageToOrders < ActiveRecord::Migration
  def change
  	add_attachment :orders,:invoice_image
  end
end
