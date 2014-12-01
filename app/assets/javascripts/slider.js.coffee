$ ->
	$("#slider").slider(
	 range: true,
	 min: 5,
	 max: 100,
	 step: 5,
	 values: [20, 80],
	 slide: (event, ui) ->
		 $("#quantity-range").text(ui.values[0] + "-" + ui.values[1])

	 stop: (event, ui) ->
	 	 fields_num = $.cookie('group_prices_fields_num')
	 	 fields_id = "#ticket_group_prices_attributes_" + fields_num
		  $(fields_id + "_range_from").attr("value", ui.values[0])
		  $(fields_id + "_range_to").attr("value", ui.values[1])
	 )
		  
	