document.addEventListener("turbolinks:load", function() {

  // Form field validation for contact form.
  $("#contact_form").validate({
    // Validation rules.
    rules: {
      name: {required: true},
      // Ensure telephone is a string of digits only.
      telephone: {digits: true, required: true},
      // Ensure email has appropriate format.
      email: {email: true, required: true}
    },
    // Custom error messages.
    messages: {
      name: {
        required: "Please enter a name."
      },
      telephone: {
        // Provide an example of valid input, if user has entered a telephone but it is invalid.
        digits: "Telephone number must be a single, unseparated number, for example: 07123456789",
        required: "Please enter a telephone number."
      },
      email: {
        // Provide an example of valid input, if user has entered an email but it is invalid.
        email: "Email address must be of the usual format, for example: joebloggs@example.com",
        required: "Please enter an email address."
      },
    }
  });

});
