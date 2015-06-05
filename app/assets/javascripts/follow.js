$(function() {
  $(".follow-btn").on("click", function (e) {
    e.preventDefault();
    var el = $(this);
    var value = this.value;
    var follower_id = $(this).data("follower-id");
    if (value === "FOLLOW") {
      $.ajax({
        url: "/followings",
        method: "POST",
        contentType: "application/json",
        // serialize the data be sending over the wire
        data: JSON.stringify({
          following: {
            follower_id: follower_id
          }
        })
      }).done(function(data){
        el.val("UNFOLLOW");
      });
    }
    else {
      $.ajax({
        url: "/followings/" + follower_id,
        method: "DELETE",
      }).done(function(){
        el.val("FOLLOW");
      });
    }
  });
});
