$(document).ready(function() {
	if($.estaPresente('#area-slider .mascota')) {
			$('#area-slider').cycle({
				timeout: 15000,
				pause: 0,     
				pauseOnPagerHover: 0,
				next: '#sig',
				prev: '#ant',
				after: function(currSlideElement, nextSlideElement, options, forwardFlag) {
					geo.posiciona(mapa, {
						lat: $(this).children('#coordenadas_lat').val(),
						lon: $(this).children('#coordenadas_lon').val(),
						zoom: 16
					});
					marcador=geo.ponMarcadorCentrado(mapa, marcador);
				}
			});
	}
});
