$(document).ready(function($) {
	var hash = window.location.hash;
	if(hash == ""){
		var Body = $('body');
    Body.addClass('preloader-site');
	} else {
		$('.preloader-wrapper').fadeOut();
	};
});

$(window).on('load', function () {
	$('.preloader-wrapper').delay(800).fadeOut();
	$('body').delay(800).removeClass('preloader-site');
});
