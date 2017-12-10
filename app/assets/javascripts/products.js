$(document).ready(function(){
  $( ".hide_side_nav_button" ).click(function() {
    $(".cart_sidebar").toggle(function() { 
      if ($( '.cart_sidebar' ).is(':visible')){
        $('#search_multiple_form').hide();
        $( '.hide_side_nav_button' ).text('Спрятать корзину');
      }
      else if ($(( '.cart_sidebar' )).is(':hidden')) {
        $( '.hide_side_nav_button' ).text('Показать корзину');
        $('#search_multiple_form').show();
      }
    });
  });
});
