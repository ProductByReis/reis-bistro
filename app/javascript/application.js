// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Marca que o JS carregou. As animações de entrada só se aplicam a partir daí,
// para a página não ficar invisível caso o JavaScript falhe.
document.documentElement.classList.add("js")
