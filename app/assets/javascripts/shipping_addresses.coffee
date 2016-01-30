$('#btn-office').click ->
	console.log "Hola"

	btn = $('#btn-office')
	check = $('#check-office')
	company = $('#shipping_address_company')
	if btn.hasClass('btn-warning')
		btn.removeClass 'btn-warning'
		btn.addClass 'btn-success'
		btn.html '<i class="fa fa-truck"></i> Oficina'
		check.val true
		company.attr 'readonly', false
	else if btn.hasClass('btn-success')
		btn.removeClass 'btn-success'
		btn.addClass 'btn-warning'
		btn.html '<i class="fa fa-home"></i> Residencia'
		check.val false
		company.attr 'readonly', true
		company.val ''