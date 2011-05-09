
var paginacionAjaxHistory = function(dom) {
	if($.estaPresente(dom)) {
		$(dom).attr('data-remote', 'true');
		
		$(dom).click(function() {
			params = $.deparam.querystring(this.href);
			
			var new_url = $.param.fragment(baseurl, params, 2);
			location.hash = $.param.fragment( new_url );
			$.cookie("ultimo", baseurl+location.hash);
			return false;
		});
	}
}

$(document).ready(function() {
	var baseurl = location.protocol + '//' + location.host + location.pathname;
	var params;
	
	if($.estaPresente('#froyito')) {
		var a = document.createElement('a');
		a.href= document.referrer;
		if((a.pathname == '/animales' || a.pathname == '/animales/') && $.cookie("ultimo") != "") {
			$('#froyito').attr('href', $.cookie("ultimo"));
			$('#froyito').click(function() {
				$.cookie("ultimo", "");
			});
		}
	}
	
	paginacionAjaxHistory('.pagination a');
	
	$(window).bind( 'hashchange', function(e) {
		params = e.fragment; // pre-jQuery1.4: $.deparam.fragment(document.location.href);
		$.getScript( $.param.querystring(baseurl, params) );
	});
	
	if (location.hash) {
	  $(window).trigger( 'hashchange' );
	}
});