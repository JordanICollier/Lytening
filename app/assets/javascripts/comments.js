$(function() {
  $('.status-container').on('click' , '.comment-box a.comment-delete', function(e) {
    e.preventDefault();
    var commentBox = $(this).closest('.comment');
    var url = commentBox.data('comment-url');
    $.ajax({
      url: url,
      method: 'DELETE',
    }).success(function() {
      commentBox.next().andSelf().remove();
    });
  });
});
