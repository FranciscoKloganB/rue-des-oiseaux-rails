import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "form"]

  show(event) {
    event.preventDefault()
    this.panelTarget.showModal()
  }

  cancel(event) {
    event?.preventDefault()
    this.panelTarget.close()
  }

  confirm(event) {
    event.preventDefault()
    this.panelTarget.close()
    this.formTarget.requestSubmit()
  }

  dismissBackdrop(event) {
    if (event.target === this.panelTarget) {
      this.cancel(event)
    }
  }
}

