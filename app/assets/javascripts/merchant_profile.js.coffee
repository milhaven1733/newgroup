initialize = ->
	position = new google.maps.LatLng(-34.397, 150.644)
	
	mapOptions =
    zoom: 8
    center: position

  map = new google.maps.Map(document.getElementById('google-map'), mapOptions)
			
	marker = new google.maps.Marker(
	  position: position
		map: map
		title: 'merchant name'
	)

google.maps.event.addDomListener window, 'load', initialize
