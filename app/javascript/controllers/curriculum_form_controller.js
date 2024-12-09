import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="curriculum-form"
export default class extends Controller {
  static targets = ["step", "submit", "nextButton"]

  connect() {
    this.currentStep = 1;
    this.lastSlide = false;
  }

  previous() {
    if (this.currentStep > 1) {
      this.currentStep -= 1;
      this.showStep();
    }
    this.lastStep = false
  }

  next() {
    if (this.currentStep < this.stepTargets.length) {
      this.currentStep += 1;
      this.showStep();
    }

    this.lastStep = this.currentStep === this.stepTargets.length
  }

  toggleControls() {
    if (this.currentStep === this.stepTargets.length) {
      this.nextButtonTarget.classList.add('d-none')
      this.submitTarget.classList.remove('d-none')
    } else {
      this.nextButtonTarget.classList.remove('d-none')
      this.submitTarget.classList.add('d-none')
    }
  }

  showStep() {
    this.stepTargets.forEach((step) => {
      step.classList.remove("active")
      if (parseInt(step.dataset.step) === this.currentStep) {
        step.classList.add("active")
      }
    });

    this.toggleControls()
  }

  submit(e) {
    e.preventDefault()
    
    if (this.lastStep) {
      e.currentTarget.submit()
    }
  }

  keyDispatcher(e) {
    if (e.key === "ArrowRight") {
      this.next()
    }

    if (e.key === "ArrowLeft") {
      this.previous()
    }
  }
}
