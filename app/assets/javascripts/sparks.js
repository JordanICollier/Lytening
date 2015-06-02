var sparks = (function() {

  return {
    spark: spark
    };

  function spark() {
    // Spark / Unspark
    $('.status-container').on('click', '.spark-icon', function(e) {
      e.preventDefault();
      var spark = $(this);
      var stryke_id = e.target.id.split(" ")[0];
      var comment_id = e.target.id.split(" ")[0];
      var user_id = e.target.id.split(" ")[1];
      var spark_id;
      var spark_num = parseInt(spark.parent().parent().children().eq(1).text());
      spark.effect("pulsate", "slow");

      // If sparked, decrement spark_count and delete spark
      if (spark.hasClass('yellow')){
        // Decrement spark_num
        spark_num--;
        // Find spark id
        spark_id = e.target.id.split(" ")[2];

        // Destroy existing spark
        $.ajax({
          url: "/sparks/" + spark_id,
          method: "DELETE",
        })
        .done(function() {
          spark.removeClass('yellow'); // Remove yellow class
          spark.addClass('white'); // Add white class
          spark.parent().parent().children().eq(1).html("<strong>" + spark_num + "</strong>"); // Update spark number
        });
      }

      // If not sparked and a comment, create a new spark with comment_id
      else if (spark.parent().parent().parent().hasClass('comment-sparks')){
        // Increment spark_num
        spark_num++;

        // Create new spark
        $.ajax({
          url: "/sparks",
          method: "POST",
          data: {
            spark: {
              user_id: user_id,
              comment_id: comment_id
            }
          }
        })
        .done(function(data) {
          spark.removeClass('white'); // Remove white class
          spark.addClass('yellow'); // Add yellow class
          spark.attr("id", "" + comment_id + " " + user_id + " " + data.id + ""); // Add spark ID as id
          spark.parent().parent().children().eq(1).html("<strong>" + spark_num + "</strong>"); // Update spark number
        });
      }

      // If not sparked and a stryke, create a new spark with stryke_id
      else if (spark.parent().parent().parent().hasClass('sparks')){
        // Increment spark_num
        spark_num++;

        // Create new spark
        $.ajax({
          url: "/sparks",
          method: "POST",
          data: {
            spark: {
              user_id: user_id,
              stryke_id: stryke_id
            }
          }
        })
        .done(function(data) {
          spark.removeClass('white'); // Remove white class
          spark.addClass('yellow'); // Add yellow class
          spark.attr("id", "" + stryke_id + " " + user_id + " " + data.id + ""); // Add spark ID as id
          spark.parent().parent().children().eq(1).html("<strong>" + spark_num + "</strong>"); // Update spark number
        });
      }

    });
  }

})();

$(function () {

  sparks.spark();

});
