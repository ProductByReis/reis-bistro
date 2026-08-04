module ApplicationHelper
  # Âncoras da navbar. Usadas no menu desktop, no menu mobile e no rodapé.
  def navegacao_principal
    [
      { rotulo: "Menu", ancora: "#menu" },
      { rotulo: "O Chef", ancora: "#chef" },
      { rotulo: "A Casa", ancora: "#casa" },
      { rotulo: "Contato", ancora: "#contato" }
    ]
  end
end
