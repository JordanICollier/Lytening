$(function() {
  // Hide Crop Photo button if No File has been chosen
  $(this).find('input[value="Crop Photo"]').hide();

  // Show crop photo button once file is chosen
  $('input[type="file"]').on("change", function() {
    $('input[value="Crop Photo"]').show();
  });
});
