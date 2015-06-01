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
//= require sparks
//= require TimeCircles
//= require_tree .

$(function() {

    $(".header").click(function () {

        $header = $(this);
        $content = $header.next();
        $content.slideToggle(250, function () {
        });

    });

// ajax call on comment

    $("#hot-comment").on('click', function(e) {
      e.preventDefault();
      var strykeId = e.target.form[2].defaultValue;
      var comment = e.target.form[3].value;
      $.ajax({
        url: "/strykes/" + strykeId + "/comments",
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({
          comment: {
            body: comment
          }
        })
      }).done(function(data){
        $('.comment-indi')
          .first()
          .children('.comment')
          .last()
          .after(data);
      });
    });

// TimeCircles
    $(".countdown").TimeCircles({
      "start": true,
      "direction": "Clockwise",
      "animation": "smooth",
      "circle_bg_color": "#F2F4D4",
      "time": {
          "Days": {
              "text": "Days",
              "color": "#FFCC66",
              "show": false
          },
          "Hours": {
              "text": "",
              "color": "#FF9999",
              "show": true
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
