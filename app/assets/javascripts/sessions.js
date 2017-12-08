$(document).ready(function(){
  $(function(){
    $('.hide-show span').addClass('show')
    $('.hide-show span').click(function(){
      if( $(this).hasClass('show') ) {
        $(this).removeClass('fa-eye').addClass('fa-eye-slash');
        $('.password-form').attr('type','text');
        $(this).removeClass('show');
      } else {
        $(this).removeClass('fa-eye-slash');
         $(this).addClass('fa-eye');
         $('.password-form').attr('type','password');
         $(this).addClass('show');
      }
    });
  });
});
