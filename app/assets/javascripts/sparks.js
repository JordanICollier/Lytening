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
      function getSparkLists() {
        return $('[data-spark-url="' + sparkUrl + '"]');
      }
      // replace and animate
      getSparkLists().replaceWith(data.template);
      var sparkLists = getSparkLists();
      sparkLists.find('.spark-icon').effect("pulsate", "slow");
      sparkLists
        .closest('[data-stryke-id]')
        .find('[data-spark-count]')
        .each(function(i) {
          var sparkCount = $(this);
          var count = +sparkCount.text();
          count += data.spark ? 1 : -1;
          sparkCount.text(count);
        });
    });
  });
});
