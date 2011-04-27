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

var marker;
var map;

function initialize() {  
		if($('#coordenadas_lat').length && $('#coordenadas_lon').length) {
   	 	var lat = $('#coordenadas_lat').val() ;
	    var lon = $('#coordenadas_lon').val() ;
    
	    if(lat == null) {
	        lat = 19.4;
	    }
    
	    if(lon == null) {
	        lon = -99.15;
	    }
    
	    var latlng = new google.maps.LatLng(parseFloat(lat), parseFloat(lon));
    
	    var myOptions = {
	        zoom: 10,
	        center: latlng,
	        mapTypeId: google.maps.MapTypeId.ROADMAP,
	        streetViewControl: true,
	        mapTypeControl: false
	    };
	    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    
	    positionOn(latlng, 10);
	    $('#coordenadas_lat').val(lat);
	    $('#coordenadas_lon').val(lon);
	    setAddressFromOn(latlng, "geografia_direccion");
    
	    google.maps.event.addListener(map, "click", function(event) {
	        positionOn(event.latLng, 15);
	        $('#coordenadas_lat').val(event.latLng.lat());
	        $('#coordenadas_lon').val(event.latLng.lng());
	        setAddressFromOn(event.latLng, "geografia_direccion");
	    });
		}
}

$(document).ready(function() {
    initialize();        
});
