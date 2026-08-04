import { Controller } from "@hotwired/stimulus"

// Controla o fundo da navbar (transparente sobre o Hero, sólido depois),
// o menu de tela cheia no mobile e a barra de reserva fixa no rodapé.
export default class extends Controller {
  static targets = ["menu", "botaoMenu", "barra"]
  static values = { limite: { type: Number, default: 80 } }

  connect() {
    this.aoRolar = this.aoRolar.bind(this)
    window.addEventListener("scroll", this.aoRolar, { passive: true })
    this.aoRolar()
  }

  disconnect() {
    window.removeEventListener("scroll", this.aoRolar)
    this.liberarRolagem()
  }

  aoRolar() {
    this.element.classList.toggle("navbar--solida", window.scrollY > this.limiteValue)

    if (this.hasBarraTarget) {
      const alturaHero = window.innerHeight * 0.75
      this.barraTarget.classList.toggle("translate-y-full", window.scrollY < alturaHero)
    }
  }

  alternarMenu() {
    const aberto = this.menuTarget.classList.toggle("hidden") === false
    this.botaoMenuTarget.setAttribute("aria-expanded", String(aberto))
    document.documentElement.style.overflow = aberto ? "hidden" : ""
  }

  fecharMenu() {
    this.menuTarget.classList.add("hidden")
    this.botaoMenuTarget.setAttribute("aria-expanded", "false")
    this.liberarRolagem()
  }

  liberarRolagem() {
    document.documentElement.style.overflow = ""
  }
}
