$(document).ready(function(){
  $('#select_rating').on('change', function() {
    if ( this.value == '1')
    {
      $(".star_id_1").show();
      $(".star_id_2").hide();
      $(".star_id_3").hide();
      $(".star_id_4").hide();
      $(".star_id_5").hide();
    }
    else if ( this.value == '2')
    {
      $(".star_id_1").hide();
      $(".star_id_2").hide();
      $(".star_id_3").hide();
      $(".star_id_4").show();
      $(".star_id_5").show();
    }
    else if ( this.value == '3')
    {
      $(".star_id_1").hide();
      $(".star_id_2").hide();
      $(".star_id_3").show();
      $(".star_id_4").show();
      $(".star_id_5").show();
    }
    else if ( this.value == '4')
    {
      $(".star_id_1").hide();
      $(".star_id_2").show();
      $(".star_id_3").show();
      $(".star_id_4").show();
      $(".star_id_5").show();
    }
    else
    {
      $(".star_id_1").show();
      $(".star_id_2").show();
      $(".star_id_3").show();
      $(".star_id_4").show();
      $(".star_id_5").show();
    }
  });
  $('#btnSubmit').click(function(e) {
    var isValid = true;
    $('.formatted_content').each(function() {
      if ($.trim($(this).val()) == '') {
        isValid = false;
        $(this).css({
            "border": "2px solid red",
            "background": "#FFCECE"
        });
      }
      else {
        $(this).css({
            "border": "",
            "background": ""
        });
      }
    });
  });
  $(function() {
    setTimeout(function(){ 
      $('.comment-alert').hide('fade');
    }, 5000);
  });
});
