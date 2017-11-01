$(document).on('ready page:load', function () {
  $(".upload-preview img").hide();
  var preview = $(".upload-preview img");

  $(".profile_upload").change(function(event){
    var input = $(event.currentTarget);
    var profile_upload = input[0].files[0];
    var reader = new FileReader();
    reader.onload = function(e){
      image_base64 = e.target.result;
      preview.show();
      preview.attr("src", image_base64);
    };
    reader.readAsDataURL(profile_upload);
  });
});
