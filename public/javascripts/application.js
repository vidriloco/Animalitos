/*
 Funciones para acciones relacionadas al mapa
*/
$.extend({
	estaPresente: function(dom) {
		return $(dom).length;
	}
});

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

var marker;
var map;

function initialize() {  
		var lon;
		var lat;
		
		if($('#coordenadas_lat').length && $('#coordenadas_lon').length) {
   	 	lat = $('#coordenadas_lat').val() ;
	    lon = $('#coordenadas_lon').val() ;
    }
	  
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
        streetViewControl: false,
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

$(document).ready(function() {
		var baseurl = location.protocol + '//' + location.host + location.pathname;
		var params;
		
		if($.estaPresente('#froyito')) {
			$('#froyito').attr('href', $.cookie("ultimo"));
		}
		
		if($.estaPresente('.pagination a')) {
			$('.pagination a').attr('data-remote', 'true');
			
			$('.pagination a').click(function() {
				params = $.deparam.querystring(this.href);
				
				var new_url = $.param.fragment(baseurl, params, 2);
				location.hash = $.param.fragment( new_url );
				$.cookie("ultimo", baseurl+location.hash);
				
				return false;
			});
		}
		
		$(window).bind( 'hashchange', function(e) {
			params = e.fragment; // pre-jQuery1.4: $.deparam.fragment(document.location.href);
			$.getScript( $.param.querystring(baseurl, params) );
		});
		
		if (location.hash) {
		  $(window).trigger( 'hashchange' );
		}
		
		
		if($.estaPresente('#map_canvas')) {
    	initialize();  
		}

		if($('#area-slider .mascota').length) {
				$('#area-slider').cycle({
					timeout: 15000,
					pause: 0,     
					pauseOnPagerHover: 0,
					next: '#sig',
					prev: '#ant',
					after: function(currSlideElement, nextSlideElement, options, forwardFlag) {
						var lat = $(this).children('#coordenadas_lat').val();
				    var lon = $(this).children('#coordenadas_lon').val();
				    var latlng = new google.maps.LatLng(parseFloat(lat), parseFloat(lon));
				    positionOn(latlng, 14);
					}
				});
		}
		
		
		
		
		if($('span#bio-show').length) {
			$('span#bio-show').bind('click', function() {
				if($('#bio').hasClass('oculto')) {
					$('#bio').removeClass('oculto');
					$(this).addClass('oculto');
					$('span#bio-hide').removeClass('oculto');
				} 
			});
		}
		
		if($('span#bio-hide').length) {
			$('span#bio-hide').bind('click', function() {
				if(!$('#bio').hasClass('oculto')) {
					$('#bio').addClass('oculto');
					$(this).addClass('oculto');
					$('span#bio-show').removeClass('oculto');
				} 
			});
		}
		
});



