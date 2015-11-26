$("#order_detail_quantity")
	.empty()
  	.append("<%= escape_javascript(render(:partial => @product_details)) %>")