// view: animales/_encabezado_show.html.erb 
$(document).bind('ajaxStart', function(){
	$('#cargando').fadeIn();
}).bind('ajaxStop', function(){
	$('#cargando').fadeOut();
});

$(document).ready(function() {
	if($.estaPresente('span#bio-show')) {
    $('span#bio-show').bind('click', function() {
   		if($('#bio').hasClass('oculto')) {
   			$('#bio').removeClass('oculto');
   			$(this).addClass('oculto');
   			$('span#bio-hide').removeClass('oculto');
   		} 
   	});
  }

  if($.estaPresente('span#bio-hide')) {
   	$('span#bio-hide').bind('click', function() {
   		if(!$('#bio').hasClass('oculto')) {
   			$('#bio').addClass('oculto');
   			$(this).addClass('oculto');
   			$('span#bio-show').removeClass('oculto');
   		} 
   	});
  }

	if($.estaPresente('#busqueda-forma')) {
		$('#esconder_busqueda').bind('click', function() {
  		$('.busqueda').fadeOut();
          return false;
  	});
  	
  	$('#mostrar_busqueda').bind('click', function() {
  		$('.busqueda').fadeIn();
          return false;
  	});
  	
  	$('#busqueda_submit').bind('click', function() {
  		$('.busqueda').hide();
  	});
	}
	
	if($.estaPresente('#ver-mas-fotos')) {
		$('#ver-mas-fotos').bind('click', function() {
			$('#fotos').fadeIn();
			return false;
    });
	}
	
	if($.estaPresente('#oculta-fotos')) {
		$('#oculta-fotos').bind('click', function() {
			$('#fotos').hide();
			$('#formulario-foto').hide();
			return false;
		});
	}
	
	if($.estaPresente('#nueva-foto')) {
		$('#nueva-foto').bind('click', function() {
	    $('#formulario-foto').fadeIn();
	    $('#acciones .mensaje .no-fotos').hide();
	    $('#acciones .mensaje .nueva-foto').fadeIn();
	    return false;
    });
	}
	
	if($.estaPresente('#cancelar-registro-foto')) {
		$('#cancelar-registro-foto').bind('click', function() {
	     $('#formulario-foto').fadeOut();
	     $('#vacio').fadeIn();
	     $('#formulario-foto .errors').empty();
		   $('#new_foto').resetForm();
		   $('#acciones .mensaje .nueva-foto').hide();
		   $('#acciones .mensaje .no-fotos').fadeIn();
		   return false;
	  });
	}
	
	if($.estaPresente('.animales .foto')) {
		$('.animales .foto').live('mouseenter', function() {
	       $(this).children('.control').addClass('opacity-on');
	       $(this).children('.control').removeClass('opacity-off');
	  }).live('mouseleave', function() {
			   $(this).children('.control').addClass('opacity-off');
				 $(this).children('.control').removeClass('opacity-on');
		});
	}
	
	var geoDireccion = function() {
		marcador=geo.ponMarcadorCentrado(mapa, marcador);
		geo.ponDireccionEn(mapa, '#direccion-en-mapa p');
	}
	
	if($.estaPresente('#coordenadas-direccion')) {
		geo.posiciona(mapa, {
			lat: $('#coordenadas-direccion .lat').text(),
			lon: $('#coordenadas-direccion .lon').text(),
			zoom: 15
		});
		geoDireccion();
	}
	
	if($.estaPresente('#mapa-editable')) {
		var lat = $('#coordenadas_lat').val();
		var lon = $('#coordenadas_lon').val();
		geo.posiciona(mapa, {
			lat: lat,
			lon: lon,
			zoom: 15
		});
		geoDireccion();
	}
});