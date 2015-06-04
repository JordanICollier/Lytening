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

  // Validations and stryke submittal
  $(".stryke-con form").on("submit", function (e) {
    e.preventDefault();
    // grab the stryke text to submit
    var strykeInput = $(this).find('textarea[name="stryke[body]"]');
    var stryke = strykeInput.val();
    var user_id = e.target[4].id;
    // Check if stryke body is empty
    if (stryke === null || stryke === "") {
      strykeInput.css("background-color", "#EEB4B4");
      $(".header-post").val("Strykes cannot be blank");
      $(".header-post").on("click", function (e) {
        strykeInput.css("background-color", "#EAF1D2");
        $(".header-post").val("");
      });
    }
    // Check if stryke body is longer than 500 characters
    else if (stryke.length > 500) {
      strykeInput.css("background-color", "#EEB4B4");
    }
    // Post stryke to database and prepend to new column
    else {
      $.ajax({
        url: "/strykes",
        method: "POST",
        contentType: "application/json",
        // serialize the data be sending over the wire
        data: JSON.stringify({
          stryke: {
            body: stryke,
            user_id: user_id
          }
        })
      }).done(function(data){
        // Append stryke to new column
        $(".new").prepend(data);
        // Slide stryke panel back up
        $(".upSlide").removeClass("upSlide");
        // clear the input
        strykeInput.val('');
        $("#textarea_feedback").html(500);
        timeCircle();
      });
    }
  });

    $(".header").click(function () {

        $header = $(this);
        $content = $header.next();
        $content.slideToggle(250, function () {
        });

    });

    //Scroll to top
    $('.back-to-top').on('click', function(e){
      e.preventDefault();
      $('html, body').animate({ scrollTop: 0 }, 'slow');
    });

    //Stryke Anywhere
    $('.spark-anywhere').on('click', function(){
        $('.header-stryke').toggleClass('upSlide');
    });
    // 500 character countdown on strykes
    var text_max = 500;
    $('#textarea_feedback').html(text_max);

    $('#textarea').keyup(function() {
      var text_length = $('#textarea').val().length;
      var text_remaining = text_max - text_length;

      $('#textarea_feedback').html(text_remaining);

      if(text_remaining < 0) {
        $("#textarea_feedback").css("color","red");
      }
      else {
        $("#textarea_feedback").css("color","black");
      }
    });


// ajax call on comment

    $('.status-container').on('submit', '.comments .form', function(e) {
      e.preventDefault();
      // find top level element
      var stryke = $(this).closest('.new-status, .top-status');
      // grab the stryke_id
      var strykeId = stryke.data('stryke-id');
      // grab the comment text to submit
      var commentInput = $(this).find('input[name="comment[body]"]');
      var comment = commentInput.val();
      // send the ajax request
      $.ajax({
        url: "/strykes/" + strykeId + "/comments",
        method: "POST",
        contentType: "application/json",
        // serialize the data be sending over the wire
        data: JSON.stringify({
          comment: {
            body: comment
          }
        })
      }).done(function(data){
        // find all strykes with the same id on the page
        var sameStrykes = $('[data-stryke-id=' + strykeId + ']');
        // add the comment to each one
        sameStrykes
          .find('.comment-list')
          .append(data);
        // clear the input
        commentInput.val('');
      });
    });

// TimeCircles
function timeCircle() {
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
  }

  timeCircle();
});
