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

//= require_tree .
$(function() {
    $( ".comments" ).accordion({
      active: false,
      collapsible: true,
      heightStyle: "content"
    });
  });

// ajax call on comment
  $(function() {
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
        console.log(data);
      });
    });

  });
