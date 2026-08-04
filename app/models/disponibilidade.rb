# Responde "que noites ainda dão" para uma faixa de datas, com uma única consulta
# ao banco — o calendário pergunta por ~31 dias × 2 turnos e não pode virar N+1.
class Disponibilidade
  # Abaixo disso a noite é anunciada como "últimas mesas".
  LIMITE_DE_ESCASSEZ = 4

  def initialize(periodo, hoje: Date.current, agora: Time.current)
    @hoje = hoje
    @agora = agora
    @ocupadas = carregar(periodo)
  end

  def self.do_mes(referencia, incluindo: [], **opcoes)
    datas = [ referencia.beginning_of_month, referencia.end_of_month, *incluindo ].compact
    new(datas.min..datas.max, **opcoes)
  end

  def mesas_restantes(data, turno)
    Reservation::MESAS_POR_TURNO - @ocupadas.fetch([ data.to_s, turno ], 0)
  end

  def turno_no_prazo?(data, turno)
    Reservation.turno_no_prazo?(data, turno, agora: @agora)
  end

  def turno_disponivel?(data, turno)
    turno_no_prazo?(data, turno) && mesas_restantes(data, turno).positive?
  end

  # :passado · :fechado · :esgotado · :ultimas · :disponivel
  def situacao(data)
    return :passado if data < @hoje
    return :fechado unless Reservation.noite_aberta?(data)
    return :fechado if data > Reservation.ultimo_dia_reservavel(hoje: @hoje)
    return :fechado if Reservation::TURNOS.none? { |turno| turno_no_prazo?(data, turno) }

    restantes = restantes_na_noite(data)
    return :esgotado if restantes.zero?

    restantes <= LIMITE_DE_ESCASSEZ ? :ultimas : :disponivel
  end

  def restantes_na_noite(data)
    Reservation::TURNOS.sum { |turno| turno_disponivel?(data, turno) ? mesas_restantes(data, turno) : 0 }
  end

  private

  def carregar(periodo)
    Reservation
      .confirmadas
      .where(data: periodo)
      .group(:data, :turno)
      .count
      .each_with_object({}) { |((data, turno), total), memo| memo[[ data.to_s, turno ]] = total }
  end
end
