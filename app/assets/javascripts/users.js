$(function() {
  new AvatarCropper();
});

function AvatarCropper() {
  this.update = update.bind(this);
  this.updatePreview = updatePreview.bind(this);
  $('#cropbox').Jcrop({
    aspectRatio: 1,
    setSelect: [0, 0, 600, 600],
    onSelect: this.update,
    onChange: this.update
  });
  return;

  function update(coords) {
    $('#user_crop_x').val(coords.x);
    $('#user_crop_y').val(coords.y);
    $('#user_crop_w').val(coords.w);
    $('#user_crop_h').val(coords.h);
    this.updatePreview(coords);
  }

  function updatePreview(coords) {
    $('#preview').css({
      width: Math.round(100/coords.w * $('#cropbox').width()) + 'px',
      height: Math.round(100/coords.h * $('#cropbox').height()) + 'px',
      marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px',
      marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'
    });
  }
}
