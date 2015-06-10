$(function() {

  // Profile validations and submittal
  $('input[value="Update User"]').on("click", function (e) {
    var first_nameInput = $(this).parent().find('input[name="user[first_name]"]');
    var first_name = first_nameInput.val();
    var last_nameInput = $(this).parent().find('input[name="user[last_name]"]');
    var last_name = last_nameInput.val();
    var usernameInput = $(this).parent().find('input[name="user[username]"]');
    var username = usernameInput.val();
    var birthdayInput = $(this).parent().find('input[name="user[birthday]"]');
    var birthday = birthdayInput.val();
    var locationInput = $(this).parent().find('input[name="user[location]"]');
    var location = locationInput.val();
    var interestInput = $(this).parent().find('input[name="user[interest]"]');
    var interest = interestInput.val();
    var schoolInput = $(this).parent().find('input[name="user[school]"]');
    var school = schoolInput.val();
    var workInput = $(this).parent().find('input[name="user[work]"]');
    var work = workInput.val();
    var aboutInput = $(this).parent().find('textarea[name="user[about]"]');
    var about = aboutInput.val();


    // Check if form fields are empty
    if (first_name === null || first_name === "") {
      e.preventDefault();
      first_nameInput.css("background-color", "#EEB4B4");
      first_nameInput.attr("placeholder", "First name cannot be blank");
      first_nameInput.on("focus", function (e) {
        first_nameInput.css("background-color", "#4586A3");
        first_nameInput.attr("placeholder", "First Name");
      });
    }

    if (last_name === null || last_name === "") {
      e.preventDefault();
      last_nameInput.css("background-color", "#EEB4B4");
      last_nameInput.attr("placeholder", "Last name cannot be blank");
      last_nameInput.on("focus", function (e) {
        last_nameInput.css("background-color", "#4586A3");
        last_nameInput.attr("placeholder", "Last Name");
      });
    }

    if (birthday === null || birthday === "") {
      birthdayInput.val(1900-01-01);
    }

    if (username === null || username === "") {
      e.preventDefault();
      usernameInput.css("background-color", "#EEB4B4");
      usernameInput.attr("placeholder", "Username cannot be blank");
      usernameInput.on("focus", function (e) {
        usernameInput.css("background-color", "#4586A3");
        usernameInput.attr("placeholder", "Username");
      });
    }

    if (location === null || location === "") {
      e.preventDefault();
      locationInput.css("background-color", "#EEB4B4");
      locationInput.attr("placeholder", "Location cannot be blank");
      locationInput.on("focus", function (e) {
        locationInput.css("background-color", "#4586A3");
        locationInput.attr("placeholder", "Location");
      });
    }

    if (interest === null || interest === "") {
      e.preventDefault();
      interestInput.css("background-color", "#EEB4B4");
      interestInput.attr("placeholder", "Interests cannot be blank");
      interestInput.on("focus", function (e) {
        interestInput.css("background-color", "#4586A3");
        interestInput.attr("placeholder", "Interests");
      });
    }

    if (school === null || school === "") {
      schoolInput.val("Enter School");
    }

    if (work === null || work === "") {
      workInput.val("Enter Work");
    }

    if (about === null || about === "") {
      aboutInput.val("Enter About");
    }
  });

});
