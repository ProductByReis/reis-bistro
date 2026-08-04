require "test_helper"

class ReservasFlowTest < ActionDispatch::IntegrationTest
  setup do
    @data = Date.current + 7
    @data += 1 until Reservation.noite_aberta?(@data)
  end

  def dados_do_cliente(**extra)
    {
      data: @data.iso8601,
      turno: "18h30",
      pessoas: 2,
      harmonizacoes: 2,
      nome: "Ana Prado",
      telefone: "(11) 3456-7890",
      email: "ana@exemplo.com",
      ocasiao: "Aniversário",
      politica: "1"
    }.merge(extra)
  end

  test "os quatro passos respondem" do
    get reservas_path
    assert_response :success
    assert_select "h1", "Quando você vem?"

    get reservas_path(data: @data.iso8601, turno: "18h30", pessoas: 2)
    assert_response :success
    assert_select ".dia--selecionado"

    get reservas_harmonizacao_path(data: @data.iso8601, turno: "18h30", pessoas: 2)
    assert_response :success
    assert_select "h1", "Vai de Reis Beer?"

    get reservas_dados_path(data: @data.iso8601, turno: "18h30", pessoas: 2,
                            harmonizacao: "sim", harmonizacoes: 2)
    assert_response :success
    assert_select "h1", "Só faltam seus dados"
  end

  test "confirmar cria a reserva e leva para a tela de confirmação" do
    assert_difference "Reservation.count", 1 do
      post reservas_path, params: { reservation: dados_do_cliente }
    end

    reserva = Reservation.last
    assert_redirected_to reservas_confirmada_path(reserva.token)

    follow_redirect!
    assert_response :success
    assert_select "h1", "Mesa reservada."
    assert_match reserva.codigo, response.body
    assert_match "R$ 1.140", response.body
  end

  test "a confirmação não expõe reserva pelo código curto" do
    post reservas_path, params: { reservation: dados_do_cliente }
    reserva = Reservation.last

    get reservas_confirmada_path(reserva.codigo)

    assert_response :not_found
    assert_no_match reserva.nome, response.body
  end

  test "erro de preenchimento volta ao passo 3 sem perder o que foi digitado" do
    assert_no_difference "Reservation.count" do
      post reservas_path, params: { reservation: dados_do_cliente(telefone: "123") }
    end

    assert_response :unprocessable_content
    assert_select "h1", "Só faltam seus dados"
    assert_select ".campo--erro"
    assert_select "input[name='reservation[nome]'][value='Ana Prado']"
  end

  test "turno esgotado volta ao passo 1 com o aviso" do
    Reservation::MESAS_POR_TURNO.times do
      Reservation.new(dados_do_cliente.merge(data: @data)).salvar_ocupando_mesa
    end

    assert_no_difference "Reservation.count" do
      post reservas_path, params: { reservation: dados_do_cliente }
    end

    assert_response :unprocessable_content
    assert_select "h1", "Quando você vem?"
    assert_select ".faixa-erro", /esgotar/
  end

  test "a noite esgotada aparece riscada no calendário" do
    Reservation::TURNOS.each do |turno|
      Reservation::MESAS_POR_TURNO.times do
        Reservation.new(dados_do_cliente.merge(turno: turno)).salvar_ocupando_mesa
      end
    end

    get reservas_path(mes: @data.beginning_of_month.iso8601)
    assert_response :success
    assert_select ".dia--esgotado"
    assert_select "button[value=?]", @data.iso8601, count: 0
  end

  test "a landing continua no ar" do
    get root_path
    assert_response :success
    assert_select "h1"
  end
end
