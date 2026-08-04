require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  # Uma quinta-feira bem dentro da janela de 90 dias, longe do corte de 2 horas.
  def noite_valida
    data = Date.current + 7
    data += 1 until Reservation.noite_aberta?(data)
    data
  end

  def atributos(**extra)
    {
      data: noite_valida,
      turno: "18h30",
      pessoas: 2,
      harmonizacoes: 2,
      nome: "Ana Prado",
      telefone: "(11) 3456-7890",
      politica: "1"
    }.merge(extra)
  end

  test "grava uma reserva válida ocupando a primeira mesa livre" do
    reserva = Reservation.new(atributos)

    assert reserva.salvar_ocupando_mesa, reserva.errors.full_messages.join(", ")
    assert_equal 1, reserva.mesa
    assert_equal "confirmada", reserva.status
    assert_match(/\ARB-[2-9A-HJ-NP-Z]{4}\z/, reserva.codigo)
    assert reserva.token.present?
  end

  test "o total soma menu e harmonização" do
    reserva = Reservation.new(atributos(pessoas: 3, harmonizacoes: 2))

    assert_equal 3 * 390 + 2 * 180, reserva.valor_total
  end

  test "recusa mesa para mais de quatro pessoas" do
    reserva = Reservation.new(atributos(pessoas: 5))

    assert_not reserva.valid?
    assert reserva.errors[:pessoas].any?
  end

  test "recusa harmonização para mais gente do que cabe na mesa" do
    reserva = Reservation.new(atributos(pessoas: 2, harmonizacoes: 3))

    assert_not reserva.valid?
    assert reserva.errors[:harmonizacoes].any?
  end

  test "recusa noite em que a casa não abre" do
    segunda = Date.current + 7
    segunda += 1 until segunda.wday == 1

    reserva = Reservation.new(atributos(data: segunda))

    assert_not reserva.valid?
    assert reserva.errors[:data].any?
  end

  test "recusa data além dos noventa dias" do
    reserva = Reservation.new(atributos(data: Date.current + 120))

    assert_not reserva.valid?
    assert reserva.errors[:data].any?
  end

  test "recusa turno inexistente" do
    reserva = Reservation.new(atributos(turno: "23h00"))

    assert_not reserva.valid?
    assert reserva.errors[:turno].any?
  end

  test "recusa reserva com menos de duas horas de antecedência" do
    data = Date.current
    data += 1 until Reservation.noite_aberta?(data)

    # Uma hora antes do turno das 18h30 daquela noite.
    travel_to Reservation.comeco_do_turno(data, "18h30") - 1.hour do
      reserva = Reservation.new(atributos(data: data, turno: "18h30"))

      assert_not reserva.valid?
      assert reserva.errors[:base].any?
    end
  end

  test "aceita reserva com folga maior que o corte de duas horas" do
    data = Date.current
    data += 1 until Reservation.noite_aberta?(data)

    travel_to Reservation.comeco_do_turno(data, "18h30") - 3.hours do
      reserva = Reservation.new(atributos(data: data, turno: "18h30"))

      assert reserva.valid?, reserva.errors.full_messages.join(", ")
    end
  end

  test "recusa a décima terceira reserva do turno" do
    data = noite_valida

    Reservation::MESAS_POR_TURNO.times do
      assert Reservation.new(atributos(data: data)).salvar_ocupando_mesa
    end

    assert_equal 0, Reservation.mesas_restantes(data, "18h30")

    excedente = Reservation.new(atributos(data: data))
    assert_not excedente.salvar_ocupando_mesa
    assert_match(/esgotar/, excedente.errors.full_messages.join(" "))
  end

  test "os dois turnos da mesma noite têm capacidade independente" do
    data = noite_valida

    Reservation::MESAS_POR_TURNO.times do
      assert Reservation.new(atributos(data: data, turno: "18h30")).salvar_ocupando_mesa
    end

    assert_equal 0, Reservation.mesas_restantes(data, "18h30")
    assert_equal Reservation::MESAS_POR_TURNO, Reservation.mesas_restantes(data, "21h00")
    assert Reservation.new(atributos(data: data, turno: "21h00")).salvar_ocupando_mesa
  end

  test "cancelar libera a mesa para outra reserva" do
    data = noite_valida
    primeira = Reservation.new(atributos(data: data))
    assert primeira.salvar_ocupando_mesa

    primeira.cancelar!

    assert_equal Reservation::MESAS_POR_TURNO, Reservation.mesas_restantes(data, "18h30")

    segunda = Reservation.new(atributos(data: data))
    assert segunda.salvar_ocupando_mesa
    assert_equal primeira.mesa, segunda.mesa
  end

  test "o banco recusa duas reservas confirmadas na mesma mesa" do
    data = noite_valida
    primeira = Reservation.new(atributos(data: data))
    assert primeira.salvar_ocupando_mesa

    # `save(validate: false)` pula os callbacks que geram código e token, então
    # eles vão à mão: o que precisa falhar aqui é o índice da mesa ocupada.
    duplicada = Reservation.new(atributos(data: data).merge(
      mesa: primeira.mesa, codigo: "RB-ZZZZ", token: "token-de-teste"
    ))

    assert_raises ActiveRecord::RecordNotUnique do
      duplicada.save(validate: false)
    end
  end

  test "recusa reserva sem aceite da política de cancelamento" do
    assert_not Reservation.new(atributos(politica: nil)).valid?
    assert_not Reservation.new(atributos(politica: "0")).valid?
  end

  test "recusa telefone incompleto" do
    reserva = Reservation.new(atributos(telefone: "9999"))

    assert_not reserva.valid?
    assert reserva.errors[:telefone].any?
  end

  test "e-mail é opcional, mas precisa ser válido quando informado" do
    assert Reservation.new(atributos(email: nil)).valid?
    assert_not Reservation.new(atributos(email: "nao-e-email")).valid?
  end
end
