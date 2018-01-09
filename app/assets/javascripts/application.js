//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require cloudinary
//= require bootstrap-sprockets
//= require social-share-button
//= require uikit
//= require trix
//= require jquery.elevatezoom
//= require jquery.raty
//= require jquery.raty.min
//= require jquery_nested_form
//= require nested_form_fields
//= require i18n
//= require i18n/translations
//= require ckeditor/init
//= require_tree .
jQuery(document).ready(function($){
  $(function() {
    setTimeout(function(){ 
      $('.message').hide('fade');
    }, 3000);
  });
  $('.comment_rating').raty();
  $(function(){
    $('.pagination a').attr('data-remote', 'false')
  });
  $("#header-menu-button-toggle").click(function(){
    $(".header-menu-items").slideToggle("slow");
    // if ($('.header-menu-items').is(":visible"))
    // {
    //   $(".header-menu-items").show();
    // } else{
    //   $(".header-menu-items").hide();
    // }
  });
});
