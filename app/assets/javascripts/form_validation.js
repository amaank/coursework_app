document.addEventListener("turbolinks:load", function() {

  $("#contact_form").validate({
    rules: {
      name: {required: true},
      telephone: {digits: true, required: true},
      email: {email: true, required: true}
    },
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
