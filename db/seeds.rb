# Reservas de exemplo para que o calendário mostre os três estados de noite
# (disponível, últimas mesas, esgotado) em desenvolvimento.
#
#   bin/rails db:seed
#
# Não roda em produção: lá a disponibilidade vem das reservas reais.
if Rails.env.production?
  puts "Seeds não rodam em produção."
  exit
end

Reservation.delete_all

NOMES = [
  "Ana Prado", "Bruno Sales", "Carla Menezes", "Diego Fontes", "Elisa Rocha",
  "Fábio Tavares", "Giovana Lima", "Heitor Nunes", "Isabel Cardoso", "João Vitor Reis",
  "Karina Dias", "Lucas Amaral"
].freeze

def criar(data:, turno:, quantidade:)
  quantidade.times do |indice|
    pessoas = [ 2, 2, 4, 1, 3 ][indice % 5]

    reserva = Reservation.new(
      data: data,
      turno: turno,
      pessoas: pessoas,
      harmonizacoes: indice.even? ? pessoas : 0,
      nome: NOMES[indice % NOMES.size],
      telefone: "(11) 9#{rand(1000..9999)}-#{rand(1000..9999)}",
      email: "reserva#{indice}@exemplo.com",
      politica: "1"
    )

    puts "  falhou: #{reserva.errors.full_messages.join(', ')}" unless reserva.salvar_ocupando_mesa
  end
end

# Primeiras noites abertas a partir de amanhã, para não bater no corte de 2 horas.
noites = (1..40)
  .map { |dias| Date.current + dias }
  .select { |data| Reservation.noite_aberta?(data) }

# Mesas vendidas em [18h30, 21h00]. O ciclo cobre os três estados que o
# calendário precisa mostrar.
lotacao = [
  [ 12, 12 ],  # noite esgotada
  [ 12, 10 ],  # últimas mesas, com um turno esgotado ao lado de outro com vaga
  [ 11, 11 ],  # últimas mesas
  [ 8, 6 ],
  [ 5, 0 ],
  [ 3, 9 ],
  [ 0, 0 ],    # noite inteira livre
  [ 6, 2 ],
  [ 11, 4 ],
  [ 2, 0 ]
]

noites.each_with_index do |data, indice|
  lotacao[indice % lotacao.size].each_with_index do |cheias, posicao|
    next if cheias.zero?

    criar(data: data, turno: Reservation::TURNOS[posicao], quantidade: cheias)
  end
end

puts "#{Reservation.confirmadas.count} reservas de exemplo criadas."
