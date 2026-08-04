# Só formatação. As regras de negócio e a disponibilidade moram em
# Reservation e Disponibilidade.
module ReservationsHelper
  MESES = %w[janeiro fevereiro março abril maio junho julho agosto setembro outubro novembro dezembro].freeze
  DIAS_DA_SEMANA = %w[domingo segunda-feira terça-feira quarta-feira quinta-feira sexta-feira sábado].freeze
  INICIAIS_DA_SEMANA = %w[D S T Q Q S S].freeze

  ENDERECO = "Rua das Oliveiras, 148 — Castanho, Jundiaí — SP".freeze

  # Contato fictício de demonstração (não é de pessoa real).
  TELEFONE = "(11) 3456-7890".freeze
  TELEFONE_E164 = "551134567890".freeze
  EMAIL = "contato@reisbistro.exemplo".freeze
  INSTAGRAM = "reisbistro".freeze
  WHATSAPP = "https://wa.me/#{TELEFONE_E164}".freeze

  def nome_do_mes(data)
    "#{MESES[data.month - 1]} de #{data.year}"
  end

  def mes_sozinho(data)
    MESES[data.month - 1]
  end

  # Pares [inicial, nome completo] para o cabeçalho do calendário.
  def cabecalho_da_semana
    INICIAIS_DA_SEMANA.zip(DIAS_DA_SEMANA)
  end

  # Ex.: "quinta-feira, 6 de agosto"
  def data_por_extenso(data)
    "#{DIAS_DA_SEMANA[data.wday]}, #{data.day} de #{MESES[data.month - 1]}"
  end

  # Semanas do mês como matriz de 7 posições, começando no domingo.
  # Posições fora do mês vêm como nil.
  def semanas_do_mes(referencia)
    primeiro = referencia.beginning_of_month
    ultimo = referencia.end_of_month

    dias = Array.new(primeiro.wday, nil) + (primeiro..ultimo).to_a
    dias += Array.new((7 - dias.size % 7) % 7, nil)
    dias.each_slice(7).to_a
  end

  def dia_selecionavel?(situacao)
    situacao.in?(%i[disponivel ultimas])
  end

  def classe_do_dia(situacao, selecionado: false)
    classes = [ "dia" ]

    case situacao
    when :esgotado then classes << "dia--esgotado"
    when :ultimas then classes << "dia--ultimas"
    when :passado, :fechado then classes << "dia--fechado"
    end

    classes << "dia--selecionado" if selecionado
    classes.join(" ")
  end

  # Texto e cor da disponibilidade de um turno, conforme ux.md item 6.3b.
  def rotulo_do_turno(disponibilidade, data, turno)
    return { texto: "selecione uma data", classe: "text-cinza-texto", indisponivel: true } if data.blank?

    unless disponibilidade.turno_no_prazo?(data, turno)
      return { texto: "fora do prazo", classe: "text-cinza-texto", indisponivel: true }
    end

    restantes = disponibilidade.mesas_restantes(data, turno)

    if restantes.zero?
      { texto: "esgotado", classe: "text-cinza-texto", indisponivel: true }
    elsif restantes <= 2
      { texto: "últimas #{pluralize(restantes, 'mesa')}", classe: "text-cobre", indisponivel: false }
    else
      { texto: pluralize(restantes, "mesa"), classe: "text-cinza-texto", indisponivel: false }
    end
  end

  def valor_total(pessoas:, harmonizacoes:)
    pessoas.to_i * Reservation::PRECO_MENU + harmonizacoes.to_i * Reservation::PRECO_HARMONIZACAO
  end

  def em_reais(valor)
    "R$ #{valor.to_i.to_s.reverse.scan(/\d{1,3}/).join('.').reverse}"
  end

  def link_google_agenda(reserva)
    return nil if reserva.comeca_em.blank?

    intervalo = [ reserva.comeca_em, reserva.termina_em ]
                .map { |momento| momento.utc.strftime("%Y%m%dT%H%M%SZ") }
                .join("/")

    parametros = {
      action: "TEMPLATE",
      text: "Reis Bistrô — menu degustação",
      dates: intervalo,
      location: ENDERECO,
      details: "Reserva #{reserva.codigo}, para #{pluralize(reserva.pessoas, 'pessoa')}. " \
               "Chegue com 10 minutos de folga."
    }

    "https://calendar.google.com/calendar/render?#{parametros.to_query}"
  end
end
