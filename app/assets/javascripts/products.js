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
  // Button showing and hiddening info about current products
  $("#info-product").click(function(){
    $(".info-about-product").toggle();
  });
  // If user checked item 'another material', the input 'another material`s name' become enable
  $(function(){
    $("#product_material_another").change(function(){
      if($("#product_material_another").prop("checked") == true){
        $("#other_desc").prop("disabled", false);
      }else{
        $("#other_desc").prop("disabled", true);
      }
    });
  });
});
// Auto count finish price
$(document).ready(function() {
  sum();
  $("#price_pur, #markups, #discount").on("keydown keyup", function() {
    sum();
  });
  function sum() {
    var price_pur = document.getElementById('price_pur').value;
    var markups = document.getElementById('markups').value;
    var discount = document.getElementById('discount').value;
    var final_price = parseFloat(price_pur) + (parseFloat(price_pur) * (parseFloat(markups) / 100));
    var price_with_discount = final_price - (final_price * (discount * 0.01));

    if (!isNaN(price_with_discount)) {
      document.getElementById('sum').value = price_with_discount.toFixed(2);
    }
  }
});
