$('.all_comments').append("<%= j(render @comment) %>");
$('.comment-form').val('');
$('.comment-success-alert').show();
