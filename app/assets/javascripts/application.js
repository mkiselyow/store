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
//= require nested_form_fields
//= require ckeditor/init
//= require_tree .
$(function() {
  setTimeout(function(){ 
    $('.message').hide('fade');
  }, 3000);
});
$('.comment_rating').raty();
