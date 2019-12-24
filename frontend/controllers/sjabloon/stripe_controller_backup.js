import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form", "card", "errors" ]

  connect() {
    console.log("connect");
    this.stripe    = Stripe(this.data.get("public-key"))
    const elements = this.stripe.elements()
    const style    = JSON.parse(this.data.get("style"))
    this.card      = elements.create("card", { style: style })

    this.card.mount(this.cardTarget)
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

  stripeTokenHandler(token) {
    const hiddenInput = document.createElement("input")

    hiddenInput.setAttribute("type", "hidden")
    hiddenInput.setAttribute("name", "stripeToken")
    hiddenInput.setAttribute("value", token.id)

    this.formTarget.appendChild(hiddenInput)
    this.formTarget.submit()
  }

  submit(event) {
    console.log("submit");
    event.preventDefault()

    this.stripe.createToken(this.card).then((result) => {
      if (result.error) {
        this.errorsTarget.textContent = result.error.message
      } else {
        this.stripeTokenHandler(result.token)
      }
    })
  }
}
