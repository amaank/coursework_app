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
    },
    // Custom error messages.
    messages: {
      "vehicle[registration_number]": {
        required: "Please enter a registration number."
      },
      "vehicle[make]": {
        // Provide an example in-case user is unsure of what should go in this field.
        required: "Please enter a make - this is the manufacturer of your vehicle, for example: Audi",
        minlength: "The make should be at least 2 characters in length."
      },
      "vehicle[model]": {
        // Identify this as a required field, and provide an explanation for why it is needed.
        required: "Please enter the model of your vehicle. This helps identify your car in-case of theft or criminal damage.",
        minlength: "The model should be at least 2 characters in length."
      }
    }
  });

});
