module HomeHelper
  # As seis etapas do menu degustação, na ordem em que são servidas.
  def etapas_do_menu
    [
      {
        nome: "Fermento Zero",
        descricao: "Pão de lúpulo assado na hora, manteiga de bacon defumado e sal de brasa.",
        imagem: "menu-01.webp",
        alt: "Pãozinho de lúpulo recém-assado com manteiga defumada em prato escuro"
      },
      {
        nome: "Margherita do Castanho",
        descricao: "Tomate de horta de Jundiaí, búfala fresca, basílico queimado. A etapa que mede a casa.",
        imagem: "menu-02.webp",
        alt: "Pizza margherita de borda tostada com tomate e búfala, em close"
      },
      {
        nome: "Niágara & Ricota",
        descricao: "Uva niágara passada no forno, ricota defumada, mel de bugre e pimenta rosa.",
        imagem: "menu-03.webp",
        alt: "Fatia de pizza branca com uvas assadas e creme de ricota defumada"
      },
      {
        nome: "Fritta de Rabada",
        descricao: "Disco frito, rabada desfiada por seis horas, agrião do rio e limão-cravo.",
        imagem: "menu-04.webp",
        alt: "Massa frita aberta revelando carne desfiada, com agrião e limão"
      },
      {
        nome: "Lúpulo & Funghi",
        descricao: "Creme de lúpulo fresco, cogumelos da serra, gema curada e avelã.",
        imagem: "menu-05.webp",
        alt: "Pizza com cogumelos e gema curada escorrendo no centro"
      },
      {
        nome: "Doce de Trigo",
        descricao: "Massa doce ao forno, doce de leite de cabra e sorvete de malte torrado.",
        imagem: "menu-06.webp",
        alt: "Sobremesa de massa doce com bola de sorvete de malte derretendo"
      }
    ]
  end

  # Os cinco rótulos da Reis Beer e a etapa que cada um acompanha.
  def rotulos_reis_beer
    [
      { nome: "Coroa", detalhe: "Pilsen de trigo · etapa 1" },
      { nome: "Castanho", detalhe: "Amber ale · etapa 2" },
      { nome: "Niágara", detalhe: "Sour de uva · etapa 3" },
      { nome: "Meia-Noite", detalhe: "Stout de café · etapas 4 e 5" },
      { nome: "Forno", detalhe: "Saison defumada · etapa 6" }
    ]
  end
end
