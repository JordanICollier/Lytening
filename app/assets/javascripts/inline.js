$(document).ready(function() {
  var user_id = $(".user-info-con").data("user-id");
  $('.fake').on("click", function(e){
    var field_name = $(e.delegateTarget).data("field-name");

    $('.edit').editable('/users/' + user_id, {
      method : "PUT",
      indicator : 'Saving...',
      tooltip   : 'Click to edit...',
      name: 'user[' + field_name + ']',
    });

    $('.edit_area').editable('/users/' + user_id, {
      method : "PUT",
      type      : 'textarea',
      cancel    : 'Cancel',
      submit    : 'OK',
      indicator : '<img src="img/indicator.gif">',
      tooltip   : 'Click to edit...',
      name: 'user[' + field_name + ']',
    });

    $('.edit_sex').editable('/users/' + user_id, {
      method : "PUT",
      data   : " {'A':'Male','B':'Female','C':'Do not specify'}",
      type   : 'select',
      submit : 'OK',
      indicator : 'Saving...',
      tooltip   : 'Click to edit...',
      name: 'user[' + field_name + ']',
    });

    $('.edit_date').editable('/users/' + user_id, {
      method : "PUT",
      type   : 'selectdate',
      submit : 'OK',
      indicator : 'Saving...',
      tooltip   : 'Click to edit...',
      name: 'user[' + field_name + ']',
    });
  });
});
