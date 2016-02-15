$ ->
	$("#show-add-detail-form-btn").click ->
		$("#add-detail-form-btn").show()
		$("#show-add-detail-form-btn").parent().parent().hide()
	$("#hide-add-detail-btn").click ->
		$("#add-detail-form-btn").hide()
		$("#show-add-detail-form-btn").parent().parent().show()

root = exports ? this

# Add a row to purchase
root.add_row = () ->
	# Set line data
	name = $('#line_name').val()
	price = $('#line_price').val()

	# Set line number
	line_tag = $("#purchase_detail #line_id_val")
	line = 1
	line_tag.each ->
		line = line + 1

	# Displays and hides
	if $("#empty_purchase_alert").is(':visible')
		$("#empty_purchase_alert").hide()
	if $("#purchase_table").hasClass('hidden')
		$("#purchase_table").removeClass('hidden')
	if $("#process_purchase").is(':hidden')
		$("#process_purchase").show()
	$("#add-detail-form-btn").hide()
	$("#show-add-detail-form-btn").parent().parent().show()
	$('#line_name').val('')
	$('#line_price').val('')
	# Append row
	$("#purchase_table #purchase_detail").append('
		<tr id="row_'+line+'">
			<td>
			  	<span id="line_id_val">'+line+'</span>
			  	<input class="hidden" value="'+line+'" name="purchase[purchase_detail][][line]">
			</td>
			<td>
			  	<span id="line_name_val">'+name+'</span>
			  	<input class="hidden" value="'+name+'" name="purchase[purchase_detail][][name]">
			</td>
			<td>
			  	Bs. <span id="line_price_val" class="price">'+price+'</span>
			  	<input class="hidden" value="'+price+'" name="purchase[purchase_detail][][price]">
			</td>
			<td class="text-center">
			  <button type="button" onclick="remove_row('+line+')" id="btn_remove_'+line+'" class="btn btn-danger btn-xs">
			    <i class="fa fa-times"></i> Remover</span>
			  </button></td>
			</td>
		</tr>')
	calculate()

# Remove the selected row from the purchase
root.remove_row = (line) ->
  $('#row_'+line).remove();
  if $("tbody#purchase_detail").children().length == 0
    $("#purchase_table").hide()
    $("#process_purchase").hide()
    $("#empty_purchase_alert").show()
  calculate()

# Calculates subtotal, tax and total
root.calculate = () ->
  # Calculate comissions
  subtotal = 0
  $("#purchase_detail .price").each ->
    # Sum subtotal
    i = parseFloat($(this).text());
    subtotal += i
  # Calculate taxes
  iva = $("#iva").val()
  tax = subtotal * iva
  # Calculate total
  total = subtotal - tax
  # To display
  $("#subtotal").text(subtotal)
  $("#tax").text(tax)
  $("#total").text(total)
  # To send as params
  $("#purchase_subtotal").val(subtotal)
  $("#purchase_tax").val(tax)
  $("#purchase_total").val(total)