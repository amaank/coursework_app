document.addEventListener("turbolinks:load", function() {

  // Form field validation for vehicle form.
  $("#new_vehicle_form").validate({
    // Validation rules.
    rules: {
      // Ensure registration number is entered.
      "vehicle[registration_number]": {required: true},
      // Ensure make is entered, and is greater than 2 in length.
      "vehicle[make]": {
        required: true,
        minlength: 2
      },
      // Ensure model is entered, and is greater than 2 in length.
      "vehicle[model]": {
        required: true,
        minlength: 2
      }
    }
  });

});
