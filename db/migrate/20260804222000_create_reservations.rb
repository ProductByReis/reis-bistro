class CreateReservations < ActiveRecord::Migration[8.1]
  def change
    create_table :reservations do |t|
      t.date :data, null: false
      t.string :turno, null: false
      t.integer :mesa, null: false
      t.integer :pessoas, null: false
      t.integer :harmonizacoes, null: false, default: 0

      t.string :nome, null: false
      t.string :telefone, null: false
      t.string :email
      t.text :restricoes
      t.string :ocasiao

      t.string :codigo, null: false
      t.string :token, null: false
      t.string :status, null: false, default: "confirmada"

      t.timestamps
    end

    add_index :reservations, :codigo, unique: true
    add_index :reservations, :token, unique: true
    add_index :reservations, [ :data, :turno ]

    # Trava de overbooking no próprio banco: duas reservas confirmadas não podem
    # ocupar a mesma mesa no mesmo turno. É o que garante a regra mesmo se dois
    # pedidos chegarem ao mesmo tempo.
    add_index :reservations, [ :data, :turno, :mesa ],
              unique: true,
              where: "status = 'confirmada'",
              name: "index_reservations_on_mesa_ocupada"
  end
end
