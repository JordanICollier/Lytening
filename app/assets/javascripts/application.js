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
//= require follow
//= require Jeditable
//= require inline
//= require_tree .

$(function() {

  var currentUrl = window.location.pathname;

  if (currentUrl === "/feed"){
    $('.toggle-top-new').html("");
    $('.toggle-top-new').html("YOUR FEED");
  } else if (currentUrl === "/all"){
    $('.toggle-top-new').html("");
    $('.toggle-top-new').html("PUBLIC FEED");
  }
  // Stryke validations and submittal
  $(".stryke-con form").on("submit", function (e) {
    e.preventDefault();
    // grab the stryke text to submit
    var strykeInput = $(this).find('textarea[name="stryke[body]"]');
    var stryke = strykeInput.val();
    var user_id = e.target[4].id;
    var countDown = $(this).parent().find('[data-area-countdown]');
    // Check if stryke body is empty
    if (stryke === null || stryke === "") {
      strykeInput.css("background-color", "#EEB4B4");
      strykeInput.val("Strykes cannot be blank");
      strykeInput.on("click", function (e) {
        strykeInput.css("background-color", "#EAF1D2");
        strykeInput.val("");
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
        // find all strykes with the same user id on the page
        var sameUser = $('[data-user-id=' + user_id + ']');
        // remove the old stryke from new column
        sameUser.parent('.new').find('[data-user-id=' + user_id + ']').remove();
        // remove the old stryke from hot column
        sameUser.parent('.top').find('[data-user-id=' + user_id + ']').remove();
        // Append stryke to new column
        $(".new").prepend(data);
        // Resize images to fit div by adding image responsive class
        $(".new img").addClass("img-responsive");
        $(".top img").addClass("img-responsive");
        // Slide stryke panel back up
        $(".upSlide").removeClass("upSlide");
        // clear the input
        strykeInput.val('');
        countDown.html(500);
        timeCircle();
      });
    }
  });

    $('.status-container').on('click', '.header', function() {
      var header = $(this);
      var content = header.next();
      console.log(content);
      content.slideToggle(250);
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

    // Mobile toggle between to and new strykes
    // var toggleStryke = 0;
    $('.stryke-sign-top-mobile').on('click', function(){
      event.preventDefault();
      $(this).addClass('selected');
      $(this).text('Looking at Top Strykes');
      $('.stryke-sign-new-mobile').removeClass('selected');
      $('.stryke-sign-new-mobile').text('Click for New Strykes');
      $('.new').addClass('hide');
      $('.top').removeClass('hide');
    });

    $('.stryke-sign-new-mobile').on('click', function(){
      event.preventDefault();
      $(this).addClass('selected');
      $(this).text('Looking at New Strykes');
      $('.stryke-sign-top-mobile').removeClass('selected');
      $('.stryke-sign-top-mobile').text('Click for Top Strykes');
      $('.new').removeClass('hide');
      $('.top').addClass('hide');
    });

    // var toggle = 0;
    // $('.toggle-top-new').on('click', function(){
    //     event.preventDefault();
    //     $('.new').toggleClass('hide');
    //     $('.top').toggleClass('hide');
    //     if (toggle === 0){
    //       $('.toggle-top-new').text('NEW');
    //       toggle = 1;
    //     } else if (toggle === 1){
    //       $('.toggle-top-new').text('TOP');
    //       toggle = 0;
    //     }
    // });

    // 500 character countdown
    var text_max = 500;
    $('[data-area-countdown]').html(text_max);
    $('.stryke-con .edit_user .header-post').on('keyup', function(e) {
      var text_length = $(this).val().length;
      var text_remaining = text_max - text_length;
      var countDown = $(e.target).parent().parent().find('[data-area-countdown]');
      countDown.html(text_remaining);

      if(text_remaining < 0) {
        countDown.css("color","red");
      }
      else {
        countDown.css("color","black");
      }
    });
    $('.comments .form').on('input', 'input[name="comment[body]"]', function(e) {
      var text_length = $(this).val().length;
      var text_remaining = text_max - text_length;
      var countDown = $(e.delegateTarget).find('[data-area-countdown]');
      countDown.html(text_remaining);

      if(text_remaining < 0) {
        countDown.css("color","red");
      }
      else {
        countDown.css("color","black");
      }
    });

    // Comment validations and submittal
    $('.status-container').on('submit', '.comments .form', function(e) {
      e.preventDefault();
      // find top level element
      var stryke = $(this).closest('.new-status, .top-status');
      // grab the stryke_id
      var strykeId = stryke.data('stryke-id');
      // grab the comment text to submit
      var commentInput = $(this).find('input[name="comment[body]"]');
      var comment = commentInput.val();
      var countDown = $(this).find('[data-area-countdown]');
      // Check if stryke body is empty
      if (comment === null || comment === "") {
        commentInput.css("background-color", "#EEB4B4");
        commentInput.val("Comments cannot be blank");
        commentInput.on("click", function (e) {
          commentInput.css("background-color", "#40ADB4");
          commentInput.val("");
        });
      }
      // Check if comment body is longer than 500 characters
      else if (comment.length > 500) {
        commentInput.css("background-color", "#EEB4B4");
      }
      // Post comment to database and append to comments list
      else {
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
          // Resize images to fit div by adding image responsive class
          $(".new img").addClass("img-responsive");
          $(".top img").addClass("img-responsive");
          // clear the input
          commentInput.val('');
          // reset counter to 500
          countDown.html(500);
        });
      }
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
