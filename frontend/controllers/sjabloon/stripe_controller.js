import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form", "card", "errors" ]

  connect() {
    console.log("connect");
    var stripe    = Stripe(this.data.get("public-key"))
    this.stripe    = Stripe(this.data.get("public-key"))
    const elements = stripe.elements()
    const style    = JSON.parse(this.data.get("style"))
    var card      = elements.create("card", { style: style })

    card.mount(this.cardTarget)

    let controller = this;

    card.addEventListener('change', function (event) {
              var displayError = controller.errorsTarget;
              if (event.error) {
                  displayError.textContent = event.error.message;
              } else {
                  displayError.textContent = '';
              }
          });


  // Handle form submission.
        var form = controller.formTarget;
        form.addEventListener('submit', function (event) {
            event.preventDefault();

            stripe.createToken(card).then(function (result) {
                if (result.error) {
                    // Inform the user if there was an error.
                    var errorElement = this.cardErrorsTarget;
                    errorElement.textContent = result.error.message;
                } else {
                    // Send the token to your server.
                    controller.stripeTokenHandler(result.token);
                }
            });
        });


  }




  change(event) {
    console.log("change");
    if (event.error) {
      console.log(this.errorsTarget);
      console.log(this);
      console.log(event);
      this.errorsTarget.textContent = event.error.message
    } else {
      this.errorsTarget.textContent = ""
    }
  }

  // stripeTokenHandler(token) {
  //   const hiddenInput = document.createElement("input")
  //
  //   hiddenInput.setAttribute("type", "hidden")
  //   hiddenInput.setAttribute("name", "stripeToken")
  //   hiddenInput.setAttribute("value", token.id)
  //
  //   this.formTarget.appendChild(hiddenInput)
  //   this.formTarget.submit()
  // }




  stripeTokenHandler(token) {
        // Insert the token ID into the form so it gets submitted to the server
        var form = this.formTarget;
        var hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('type', 'hidden');
        hiddenInput.setAttribute('name', 'stripeToken');
        hiddenInput.setAttribute('value', token.id);
        form.appendChild(hiddenInput);

        // Submit the form
        form.submit();
    }






  // submit(event) {
  //   console.log("submit");
  //   event.preventDefault()
  //
  //   // stripe.createToken(this.card).then((result) => {
  //   //   if (result.error) {
  //   //     this.errorsTarget.textContent = result.error.message
  //   //   } else {
  //   //     this.stripeTokenHandler(result.token)
  //   //   }
  //   // })
  //
  //
  //   //
  //   // this.stripe.createToken(this.card).then(function (result) {
  //   //      if (result.error) {
  //   //          // Inform the user if there was an error.
  //   //          var errorElement = this.cardErrorsTarget;
  //   //          errorElement.textContent = result.error.message;
  //   //      } else {
  //   //          // Send the token to your server.
  //   //          controller.stripeTokenHandler(result.token);
  //   //      }
  //   //  });
  //
  // }



}
