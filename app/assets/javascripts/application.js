// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.Jcrop
//= TimeCircles
//= require_tree .
$(function() {
    $( ".comments" ).accordion({
      active: false,
      collapsible: true,
      heightStyle: "content"
    });

    $(".countdown").TimeCircles({
      "start": true,
      "direction": "Counter-clockwise",
      "animation": "smooth",
      "time": {
          "Days": {
              "text": "Days",
              "color": "#FFCC66",
              "show": false
          },
          "Hours": {
              "text": "Hours",
              "color": "#99CCFF",
              "show": false
          },
          "Minutes": {
              "text": "Minutes",
              "color": "#BBFFBB",
              "show": false
          },
          "Seconds": {
              "text": "Seconds",
              "color": "#FF9999",
              "show": false
          }
      }
    });
});
