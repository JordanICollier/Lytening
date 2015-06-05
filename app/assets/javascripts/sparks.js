$(function() {
  // Spark / Unspark
  $('.status-container').on('click', '.spark-list', function(e) {
    e.preventDefault();
    var elem = $(this);
    var url = elem.data('spark-url');
    $.ajax({
      url: url,
    }).success(function(data) {
      elem.replaceWith(data)
    });
  });
});
