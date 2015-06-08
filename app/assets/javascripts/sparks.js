$(function() {
  // Spark / Unspark
  $('.status-container').on('click', '.spark-list', function(e) {
    e.preventDefault();
    var elem = $(this);
    var url = elem.data('spark-url');
    $.ajax({
      url: url,
    }).success(function(data) {
      // find the stryke_id from the current container
      var strykeId = elem.closest('[data-stryke-id]').data('stryke-id');
      // find the spark lists to replace
      var strykes = $('[data-stryke-id="' + strykeId + '"]');
      var sparkLists = strykes.find('.sparks .spark-list');
      // update the DOM
      sparkLists.replaceWith($(data));
      // re-find spark lists after replacement
      sparkLists = strykes.find('.sparks .spark-list');
      // animate
      sparkLists.find('.spark-icon').effect("pulsate", "slow");
    });
  });
});
