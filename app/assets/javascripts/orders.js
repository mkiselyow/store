$(document).ready(function(){
  $('#select_delivery').on('change', function() {
    if ( this.value == 'Новая почта')
    {
      $(".number_post_office").show();
    }
    else if ( this.value == 'Мист-Експресс')
    {
      $(".number_post_office").show();
    }
    else
    {
      $(".number_post_office").hide();
    }
  });
});
