$(document).ready(function(){
  $('#add_comment_for_post').click(function(e) {
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
});
