class Reservation < ApplicationRecord
  # Regras de negócio da casa (ux.md, item 6.0). Este é o único lugar onde elas moram.
  NOITES_ABERTAS = [ 0, 4, 5, 6 ].freeze          # domingo, quinta, sexta, sábado
  TURNOS = [ "18h30", "21h00" ].freeze
  MESAS_POR_TURNO = 12                            # uma reserva ocupa uma mesa, de 1 a 4 pessoas
  MAXIMO_DE_PESSOAS = 4
  JANELA_DE_DIAS = 90
  ANTECEDENCIA_MINIMA = 2.hours
  DURACAO = 2.5.hours

  PRECO_MENU = 390
  PRECO_HARMONIZACAO = 180

  OCASIOES = [ "Nenhuma", "Aniversário", "Comemoração", "Primeira visita" ].freeze
  SITUACOES = %w[confirmada cancelada].freeze

  # Sem 0/O e 1/I: o código é lido em voz alta na recepção.
  ALFABETO_DO_CODIGO = "23456789ABCDEFGHJKLMNPQRSTUVWXYZ".chars.freeze

  # A tela promete "li e aceito". Sem isso no servidor, um POST direto passaria
  # sem aceite nenhum.
  attr_accessor :politica

  scope :confirmadas, -> { where(status: "confirmada") }
  scope :no_turno, ->(data, turno) { where(data: data, turno: turno) }
  scope :da_noite, ->(data) { where(data: data).order(:turno, :mesa) }

  before_validation :ocupar_mesa_livre, on: :create
  before_validation :gerar_identificadores, on: :create

  validates :nome, presence: true, length: { maximum: 120 }
  validates :telefone, presence: true, format: { with: /\A[\d\s()+-]{10,20}\z/, message: "parece incompleto. Inclua o DDD." }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "não parece válido." }, allow_blank: true
  validates :data, presence: true
  validates :turno, inclusion: { in: TURNOS, message: "não existe." }
  validates :pessoas, inclusion: { in: 1..MAXIMO_DE_PESSOAS, message: "precisa ser de 1 a #{MAXIMO_DE_PESSOAS}. Para grupos maiores, fale com a casa." }
  validates :harmonizacoes, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :ocasiao, inclusion: { in: OCASIOES }, allow_blank: true
  validates :status, inclusion: { in: SITUACOES }
  validates :codigo, :token, presence: true, uniqueness: true
  # `allow_nil: false` é o que importa: sem isso, um POST que simplesmente omite
  # o campo passaria pela validação.
  validates :politica,
            acceptance: { accept: [ "1", true ], allow_nil: false,
                          message: "precisa ser aceita para confirmar a reserva." },
            on: :create

  validate :harmonizacoes_cabem_na_mesa
  validate :noite_de_funcionamento
  validate :dentro_da_janela
  validate :respeita_antecedencia, on: :create
  validate :turno_tem_mesa_livre, on: :create

  def self.mesas_restantes(data, turno)
    MESAS_POR_TURNO - confirmadas.no_turno(data, turno).count
  end

  def self.primeira_mesa_livre(data, turno)
    ocupadas = confirmadas.no_turno(data, turno).pluck(:mesa)
    (1..MESAS_POR_TURNO).find { |numero| ocupadas.exclude?(numero) }
  end

  def self.noite_aberta?(data)
    NOITES_ABERTAS.include?(data.wday)
  end

  def self.comeco_do_turno(data, turno)
    return nil if data.blank? || TURNOS.exclude?(turno)

    hora, minuto = turno.split("h")
    Time.zone.local(data.year, data.month, data.day, hora.to_i, minuto.to_i)
  end

  # Um turno para de aceitar reserva duas horas antes de começar.
  def self.turno_no_prazo?(data, turno, agora: Time.current)
    comeco = comeco_do_turno(data, turno)
    comeco.present? && comeco >= agora + ANTECEDENCIA_MINIMA
  end

  def self.ultimo_dia_reservavel(hoje: Date.current)
    hoje + JANELA_DE_DIAS
  end

  # O índice único do banco é a trava real contra overbooking. Se dois pedidos
  # escolherem a mesma mesa no mesmo instante, o segundo tenta a mesa seguinte.
  def salvar_ocupando_mesa
    tentativas = 3

    begin
      save
    rescue ActiveRecord::RecordNotUnique
      tentativas -= 1
      raise if tentativas.zero?

      self.mesa = nil
      self.codigo = nil
      self.token = nil
      errors.clear
      retry
    end
  end

  def comeca_em
    self.class.comeco_do_turno(data, turno)
  end

  def termina_em
    comeca_em && comeca_em + DURACAO
  end

  def valor_total
    pessoas.to_i * PRECO_MENU + harmonizacoes.to_i * PRECO_HARMONIZACAO
  end

  def harmoniza?
    harmonizacoes.to_i.positive?
  end

  def cancelar!
    update!(status: "cancelada")
  end

  private

  def turno_valido?
    turno.presence_in(TURNOS)
  end

  def ocupar_mesa_livre
    return if data.blank? || turno_valido?.blank? || mesa.present?

    self.mesa = self.class.primeira_mesa_livre(data, turno)
  end

  def gerar_identificadores
    self.codigo ||= "RB-#{4.times.map { ALFABETO_DO_CODIGO.sample }.join}"
    self.token ||= SecureRandom.urlsafe_base64(16)
  end

  def harmonizacoes_cabem_na_mesa
    return if harmonizacoes.blank? || pessoas.blank?
    return if harmonizacoes <= pessoas

    errors.add(:harmonizacoes, "não pode passar do número de pessoas da mesa.")
  end

  def noite_de_funcionamento
    return if data.blank? || self.class.noite_aberta?(data)

    errors.add(:data, "não é uma noite de funcionamento. Abrimos de quinta a domingo.")
  end

  def dentro_da_janela
    return if data.blank?
    return if data <= self.class.ultimo_dia_reservavel

    errors.add(:data, "está além dos #{JANELA_DE_DIAS} dias que abrimos para reserva.")
  end

  def respeita_antecedencia
    return if comeca_em.blank?
    return if comeca_em >= Time.current + ANTECEDENCIA_MINIMA

    errors.add(:base, "Este horário já está a menos de 2 horas. Fale com a casa pelo WhatsApp.")
  end

  def turno_tem_mesa_livre
    return if data.blank? || turno_valido?.blank?
    return if mesa.present?

    errors.add(:base, "Este turno acabou de esgotar. Escolha outra data ou horário.")
  end
end
