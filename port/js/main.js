//Scroll and Animation

var $animation_elements_right = $('.animation-element-right');
var $animation_elements_left = $('.animation-element-left');
var $animation_elements_rotate = $('.animation-element-rotate');
var $window = $(window);

function check_if_in_view() {
  var window_height = $window.height();
  var window_top_position = $window.scrollTop();
  var window_bottom_position = (window_top_position + window_height);
  var window_width = $window.width();

  //slideRight
  $.each($animation_elements_right, function() {
    var $element = $(this);
    var element_height = $element.outerHeight();
    var element_top_position = $element.offset().top;
    var element_bottom_position = (element_top_position + element_height);

    //check to see if this current container is within viewport
    if ((element_bottom_position >= window_top_position) &&
      (element_top_position <= window_bottom_position) && (window_width >= 768)){
      $element.addClass('animated slideInRight');
    } else {
      $element.removeClass('animated slideInRight');
    }
  });

  //slideLeft
  $.each($animation_elements_left, function() {
    var $element = $(this);
    var element_height = $element.outerHeight();
    var element_top_position = $element.offset().top;
    var element_bottom_position = (element_top_position + element_height);

    //check to see if this current container is within viewport
    if ((element_bottom_position >= window_top_position) &&
      (element_top_position <= window_bottom_position) && (window_width >= 768)) {
      $element.addClass('animated slideInLeft');
    } else {
      $element.removeClass('animated slideInLeft');
    }
  });

  //RotateIn
  $.each($animation_elements_rotate, function() {
    var $element = $(this);
    var element_height = $element.outerHeight();
    var element_top_position = $element.offset().top;
    var element_bottom_position = (element_top_position + element_height);

    //check to see if this current container is within viewport
    if ((element_bottom_position >= window_top_position) &&
      (element_top_position <= window_bottom_position)) {
      $element.delay(2000).addClass('animated rotateIn');
    } else {
      $element.removeClass('animated rotateIn');
    }
  });

}

$window.on('scroll resize', check_if_in_view);
$window.trigger('scroll');


// $("#test").addClass('animated rotateIn');

//Scroll and change nav color
$(function () {
  $(document).scroll(function () {
	  var $nav = $(".navbar-fixed-top");
	  $nav.toggleClass('scrolled', $(this).scrollTop() > $nav.height());
	});
});


//Smooth Scroll
$(document).ready(function(){
  // Add smooth scrolling to all links
  $("a").on('click', function(event) {

    // Make sure this.hash has a value before overriding default behavior
    if (this.hash !== "") {
      // Prevent default anchor click behavior
      event.preventDefault();

      // Store hash
      var hash = this.hash;

      // Using jQuery's animate() method to add smooth page scroll
      // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
      $('html, body').animate({
        scrollTop: $(hash).offset().top
      }, 800, function(){

        // Add hash (#) to URL when done scrolling (default click behavior)
        window.location.hash = hash;
      });
    } // End if
  });
});
