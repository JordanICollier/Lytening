$(function() {
  // don't do anything if we are not on the feed page
  if (window.location.pathname !== '/feed') { return; }
  // select the window and document once
  var jqDoc = $(document);
  var jqWin = $(window);
  // flags that disallow requests
  var loading = false;
  var endOfData = false;
  // initial offset
  var offset = $('.new-status').size();
  // bind scroll event to the document
  jqDoc.on('scroll', function() {
    // don't do anyting if loading or there is no data left
    if (loading || endOfData) { return; }
    // cacluate page and window height, and how far we've scrolled
    var totalHeight = jqDoc.height();
    var windowHeight = jqWin.height()
    var scrollBottom = jqDoc.scrollTop() + windowHeight;
    // if there is more than once page left
    if (totalHeight - scrollBottom >= windowHeight) { return; }
    // set loading
    loading = true;
    // make the request
    $.ajax({
      url: '/strykes',
      data: {offset: offset},
    }).success(function(data) {
      // update flags
      loading = false;
      endOfData = data.done
      // increase the offset for next time
      offset += data.size;
      console.log(data);
      // add new data to the page
      $('.status-container .top').append(data.top);
      $('.status-container .new').append(data.new);
    });
  });
});
