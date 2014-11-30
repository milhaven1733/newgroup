to_percentage = (num) ->
	if num > 0 and num < 1
	  (num * 100) + '%'
	else
		num

from_percentage = (str) ->
	if str.charAt(str.length-1) is '%'
		num = str.substring(0,str.length-1)
		if isNaN(num)
			null
		else
			num / 100.0
	else
		str
		
$ ->
	$('#ticket_oprice').change ->
		$('#ticket_flat_discount').removeAttr('disabled')
		$('#ticket_flat_price').removeAttr('disabled')
		
  $("#ticket_flat_discount").change ->
    oprice = $("#ticket_oprice").val()
    discount = from_percentage( $(this).val() )
    $("#ticket_flat_price").val oprice*discount
		
	$("#ticket_flat_price").change ->
    oprice = $("#ticket_oprice").val()
    price = $(this).val()
    $("#ticket_flat_discount").val price / oprice
		
	$('#has-student-discount').click ->
		if $(this).is(':checked')
		  $('#ticket_student_discount').prop('disabled', false)
		else
		  $('#ticket_student_discount').prop('disabled', true)
			
	$('#free-shipping').click ->
		$('#ticket_shipping').val(0) if $(this).prop('checked')
	
	$('#price-tiers').click (event) ->
		event.preventDefault()
		$('#group-price-tiers').modal('show')
	
	$('#group-price-tiers-list').hide()
	
	$('#group-price-tiers-add').click (event) ->
		event.preventDefault()
		range_from = $('#group_prices_range_from').val()
		range_to = $('#group_prices_range_to').val()
		range = range_from + " - " + range_to
		price = $('#group_prices_price').val()
		$('#group-price-tiers-table tbody').append("<tr><td>" + range + "</td><td>$" + price + "</td></tr>")