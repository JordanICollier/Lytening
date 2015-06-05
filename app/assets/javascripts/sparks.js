$(function() {
  // Spark / Unspark
  $('.status-container').on('click', '.spark-list', function(e) {
    e.preventDefault();
    var elem = $(this);
    var url = elem.data('spark-url');
    $.ajax({
      url: url,
    }).success(function(data) {
      var newElem = $(data);
      elem.replaceWith(newElem)
      newElem.find('.spark-icon').effect("pulsate", "slow");
    });
  });
});
