$(function() {
  // Spark / Unspark
  $('.status-container').on('click', '.spark-list', function(e) {
    e.preventDefault();
    var elem = $(this);
    var url = elem.data('spark-url');
    $.ajax({
      url: url,
    }).success(function(data) {
      // find the spark url
      var sparkUrl = elem.data('spark-url');
      // we use this to regrab the spark list after the replacement
      function sparkLists() {
        return $('[data-spark-url="' + sparkUrl + '"]');
      }
      // replace and animate
      sparkLists().replaceWith(data);
      sparkLists().find('.spark-icon').effect("pulsate", "slow");
    });
  });
});
