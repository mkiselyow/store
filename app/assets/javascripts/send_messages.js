$(document).ready(function(){
  $('#SendFormSubmit').click(function(e) {
    var isValid = true;
    $('.alert-send-message').show();
    $('.formatted_content').each(function() {
      if ($.trim($(this).val()) == '') {
        isValid = false;
        $(this).css({
          "border": "2px solid blue",
        });
        $('.fail_message').show();
        $('.success_message').hide();
      }
      else {
        $(this).css({
          "border": "",
        });
        $('.fail_message').hide();
        $('.success_message').show();
      }
      $(function() {
        setTimeout(function(){ 
          $('.alert-send-message').hide('fade');
        }, 5000);
      });
    });
  });
});
