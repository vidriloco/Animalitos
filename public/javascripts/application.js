/*
 Funciones para acciones relacionadas al mapa
*/

function setAddressFromOn(coord, domElement) {
	var geocoder = new google.maps.Geocoder();
      
	geocoder.geocode({'location': coord}, function(results, status) {            
		if (status == google.maps.GeocoderStatus.OK) {
			var address = results[0].formatted_address;
			$('#'+domElement).html(""+address+"");
		} 
	});
}

function positionOn(coord, zoom) {
	if(marker != null) {
		marker.setMap(null);
	}
      
	if(map != null) {
		marker = new google.maps.Marker({
			position: coord, 
			map: map
		});
		map.setCenter(coord);
		map.setZoom(zoom);
	}
}

$(document).bind('ajaxStart', function(){
	$('#cargando').fadeIn();
}).bind('ajaxStop', function(){
	$('#cargando').fadeOut();
});

$(document).ready(function() {
	$('.pagination a').attr('data-remote', 'true');
});
