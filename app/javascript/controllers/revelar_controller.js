import { Controller } from "@hotwired/stimulus"

// Revela o elemento com fade-in quando ele entra na viewport, uma única vez.
export default class extends Controller {
  connect() {
    if (!("IntersectionObserver" in window)) {
      this.element.classList.add("revelado")
      return
    }

    this.observador = new IntersectionObserver(
      (entradas) => {
        entradas.forEach((entrada) => {
          if (!entrada.isIntersecting) return
          entrada.target.classList.add("revelado")
          this.observador.unobserve(entrada.target)
        })
      },
      { rootMargin: "0px 0px -12% 0px", threshold: 0.05 }
    )

    this.observador.observe(this.element)
  }

  disconnect() {
    this.observador?.disconnect()
  }
}
