$('.all_comments').append("<%= j(render @comment) %>");
$('.comment-form').val('');
$('.comment-alert').show();
$('.alert').addClass('alert-success').append("<%= raw t('reviews.success_message') %>");
