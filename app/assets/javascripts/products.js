$(document).ready(function(){
  $("#info-product").click(function(){
    $(".info-about-product").slideToggle( "slow" );
    $("#info-product").text(function(i, text){
      return text === 'Показать информацию' ? "Спрятать информацию": 'Показать информацию';
    })
  });
  $("#info-product-mobile").click(function(){
    $(".info-about-product-mobile").slideToggle( "slow" );
    $("#info-product-mobile").text(function(i, text){
      return text === 'Показать информацию' ? "Спрятать информацию": 'Показать информацию';
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
