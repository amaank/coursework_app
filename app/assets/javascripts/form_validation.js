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
      telephone: {
        digits: "This must be a single, unseparated number"
      },
      email: {
        email: "Enter a valid email address"
      },
    }
  });

});
