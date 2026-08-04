class ReservationsController < ApplicationController
  # Estados que ainda não têm gatilho real e ficam disponíveis para revisão de
  # design (ux.md, item 6.8). Saem quando houver dados de verdade em produção.
  ESTADOS_DE_PREVIA = %w[vazio carregando].freeze

  before_action :carregar_escolhas, only: %i[new harmonizacao dados]
  before_action :carregar_estado_de_previa, only: %i[new]

  # Passo 1 — data, horário e pessoas.
  def new
    carregar_calendario
  end

  # Passo 2 — harmonização Reis Beer.
  def harmonizacao
  end

  # Passo 3 — dados de contato.
  def dados
    @reserva = Reservation.new(
      data: @data, turno: @turno, pessoas: @pessoas, harmonizacoes: @harmonizacoes
    )
  end

  def create
    @reserva = Reservation.new(parametros_da_reserva)

    if @reserva.salvar_ocupando_mesa
      redirect_to reservas_confirmada_path(@reserva.token)
    else
      reexibir_passo_com_erro
    end
  end

  def confirmada
    @reserva = Reservation.find_by!(token: params[:token])
  end

  private

  def parametros_da_reserva
    params.expect(
      reservation: [ :data, :turno, :pessoas, :harmonizacoes,
                     :nome, :telefone, :email, :restricoes, :ocasiao, :politica ]
    )
  end

  def carregar_escolhas
    @data = data_escolhida
    @turno = params[:turno].presence_in(Reservation::TURNOS)
    @pessoas = params[:pessoas].to_i.clamp(0, Reservation::MAXIMO_DE_PESSOAS)
    @harmonizacoes = pessoas_que_harmonizam
  end

  # O passo 2 manda duas coisas: se a mesa quer harmonizar e, se quiser, para
  # quantas pessoas. Fora do "sim" explícito, a quantidade é irrelevante.
  def pessoas_que_harmonizam
    return 0 unless params[:harmonizacao] == "sim"
    return 0 if @pessoas.zero?

    quantidade = params[:harmonizacoes].presence || @pessoas
    quantidade.to_i.clamp(1, @pessoas)
  end

  def data_escolhida
    Date.iso8601(params[:data].to_s)
  rescue Date::Error
    nil
  end

  def carregar_calendario
    @referencia = mes_de_referencia
    @disponibilidade = Disponibilidade.do_mes(@referencia, incluindo: [ @data ])
  end

  def mes_de_referencia
    Date.iso8601(params[:mes].to_s).beginning_of_month
  rescue Date::Error
    (@data || Date.current).beginning_of_month
  end

  def carregar_estado_de_previa
    @estado = params[:estado].presence_in(ESTADOS_DE_PREVIA)
  end

  # Erro no que foi escolhido no passo 1 volta para o calendário; erro de
  # preenchimento fica no passo 3, com tudo que o cliente já digitou.
  def reexibir_passo_com_erro
    @data = @reserva.data
    @turno = @reserva.turno
    @pessoas = @reserva.pessoas.to_i
    @harmonizacoes = @reserva.harmonizacoes.to_i

    if erro_na_escolha_do_passo_1?
      carregar_calendario
      render :new, status: :unprocessable_content
    else
      render :dados, status: :unprocessable_content
    end
  end

  def erro_na_escolha_do_passo_1?
    (@reserva.errors.attribute_names & %i[base data turno pessoas]).any?
  end
end
