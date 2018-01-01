$(document).ready(function(){
  $("#info-product").click(function(){
    $(".info-about-product").toggle();
    $("#info-product").text(function(i, text){
      return text === "Больше информации" ? "Спрятать информацию": "Больше информации";
    })
  });
  $("#info-product-mobile").click(function(){
    $(".info-about-product-mobile").toggle();
    $("#info-product-mobile").text(function(i, text){
      return text === "Больше информации" ? "Спрятать информацию": "Больше информации";
    })
  });
  $(function(){
    $("#product_material_another").change(function(){
      if($("#product_material_another").prop("checked") == true){
        $("#other_desc").prop("disabled", false);
      }else{
        $("#other_desc").prop("disabled", true);
      }
    });
  });
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
