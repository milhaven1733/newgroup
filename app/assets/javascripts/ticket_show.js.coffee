cal_booking_fee = (quantity) ->
	if quantity > 50 then 10 else 5
	
is_exeed = (quantity, amount) ->
	if quantity > amount then amount else quantity
	
$ ->
	$('#order_count').change ->
		flat_price = $.cookie('flat_price')
		amount = $.cookie('amount')
		quantity = $('#order_count').val()
		total = flat_price * quantity
		$('#total-price').text('$' + total)
		$('#order_price').val(total)
		booking_fee = cal_booking_fee(quantity)
		$('#booking-fee').text('$' + booking_fee)
		$('#order_booking_fee').val(booking_fee)