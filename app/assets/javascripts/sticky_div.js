$(document).ready(function(){

// Фиксация


  var $window = $(window),
  $navigation = $(".sticky");

  $window.scroll(function() {
    if (!$navigation.hasClass("fixed") && ($window.scrollTop() > $navigation.offset().top)) {
        $navigation.addClass("fixed").data("top", $navigation.offset().top);
    }
    else if ($navigation.hasClass("fixed") && ($window.scrollTop() < $navigation.data("top"))) {
        $navigation.removeClass("fixed");
    }
  }); 



});