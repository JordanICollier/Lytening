var sparks = (function() {

  return {
    spark: spark
    };

  function spark() {
    // Spark / Unspark
    $('.spark-icon').click(function(e) {
      e.preventDefault();
      var spark = $(e.delegateTarget);
      var stryke_id = e.target.id[0];
      var comment_id = e.target.id[0];
      var user_id = e.target.id[2];
      var spark_count_stryke;
      var spark_count_comment;
      var spark_count_user;
      // spark.effect("pulsate", "slow");

      // If sparked and a comment, decrement spark_count in comments table
      if (spark.hasClass('sparked') && spark.parent().parent().parent().hasClass('comment-sparks')){
        // Grab existing spark_count from comments table
        $.ajax({
            url: '/comments/' + comment_id,
            method: "GET"
        })
        // Decrement spark_count_comment
        .done(function(data) {
          spark_count_comment = data.spark_count;
          spark_count_comment--;
          // Update spark_count in comments table
          $.ajax({
              url: '/comments/' + comment_id,
              method: "PATCH",
              data: {comment: {spark_count: spark_count_comment}}
          })
          .done(function() {
            spark.removeClass('sparked'); // Remove sparked class
            spark.parent().parent().children().eq(1).html("<strong>" + spark_count_comment + "</strong>"); // Update spark number
          });
        });

        // Grab existing spark_count from users table
        $.ajax({
            url: '/users/' + user_id,
            method: "GET"
        })
        // Decrement spark_count_user
        .done(function(data) {
          spark_count_user = data.spark_count;
          spark_count_user--;
          // Update spark_count in users table
          $.ajax({
              url: '/users/' + user_id,
              method: "PATCH",
              data: {user: {spark_count: spark_count_user}}
          });
        });
      }

      // If not sparked and a comment, increment spark_count in comments table
      else if (spark.parent().parent().parent().hasClass('comment-sparks')){
        // Grab existing spark_count from comments table
        $.ajax({
            url: '/comments/' + comment_id,
            method: "GET"
        })
        // Increment spark_count_comment
        .done(function(data) {
          spark_count_comment = data.spark_count;
          spark_count_comment++;
          // Update spark_count in comments table
          $.ajax({
              url: '/comments/' + comment_id,
              method: "PATCH",
              data: {comment: {spark_count: spark_count_comment}}
          })
          .done(function() {
            spark.addClass('sparked'); // Add sparked class
            spark.parent().parent().children().eq(1).html("<strong>" + spark_count_comment + "</strong>"); // Update spark number
          });
        });

        // Grab existing spark_count from users table
        $.ajax({
            url: '/users/' + user_id,
            method: "GET"
        })
        // Increment spark_count_user
        .done(function(data) {
          spark_count_user = data.spark_count;
          spark_count_user++;
          // Update spark_count in users table
          $.ajax({
              url: '/users/' + user_id,
              method: "PATCH",
              data: {user: {spark_count: spark_count_user}}
          });
        });
      }

      // If sparked and a stryke, decrement spark_count in strykes table
      else if (spark.hasClass('sparked') && spark.parent().parent().parent().hasClass('sparks')){
        // Grab existing spark_count from strykes table
        $.ajax({
            url: '/strykes/' + stryke_id,
            method: "GET"
        })
        // Decrement spark_count_stryke
        .done(function(data) {
          spark_count_stryke = data.spark_count;
          spark_count_stryke--;
          // Update spark_count in strykes table
          $.ajax({
              url: '/strykes/' + stryke_id,
              method: "PATCH",
              data: {stryke: {spark_count: spark_count_stryke}}
          })
          .done(function() {
            spark.removeClass('sparked'); // Remove sparked class
            spark.parent().parent().children().eq(1).html("<strong>" + spark_count_stryke + "</strong>"); // Update spark number
          });
        });

        // Grab existing spark_count from users table
        $.ajax({
            url: '/users/' + user_id,
            method: "GET"
        })
        // Decrement spark_count_user
        .done(function(data) {
          spark_count_user = data.spark_count;
          spark_count_user--;
          // Update spark_count in users table
          $.ajax({
              url: '/users/' + user_id,
              method: "PATCH",
              data: {user: {spark_count: spark_count_user}}
          });
        });
      }

      // If not sparked and a stryke, increment spark_count in strykes table
      else if (spark.parent().parent().parent().hasClass('sparks')){
        // Grab existing spark_count from strykes table
        $.ajax({
            url: '/strykes/' + stryke_id,
            method: "GET"
        })
        // Increment spark_count_stryke
        .done(function(data) {
          spark_count_stryke = data.spark_count;
          spark_count_stryke++;
          // Update spark_count in strykes table
          $.ajax({
              url: '/strykes/' + stryke_id,
              method: "PATCH",
              data: {stryke: {spark_count: spark_count_stryke}}
          })
          .done(function() {
            spark.addClass('sparked'); // Add sparked class
            spark.parent().parent().children().eq(1).html("<strong>" + spark_count_stryke + "</strong>"); // Update spark number
          });
        });

        // Grab existing spark_count from users table
        $.ajax({
            url: '/users/' + user_id,
            method: "GET"
        })
        // Increment spark_count_user
        .done(function(data) {
          spark_count_user = data.spark_count;
          spark_count_user++;
          // Update spark_count in users table
          $.ajax({
              url: '/users/' + user_id,
              method: "PATCH",
              data: {user: {spark_count: spark_count_user}}
          });
        });
      }

    });
  }

})();

$(function () {

  sparks.spark();

});
