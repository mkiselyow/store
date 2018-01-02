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
});
