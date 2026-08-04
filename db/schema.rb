# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_04_222000) do
  create_table "reservations", force: :cascade do |t|
    t.string "codigo", null: false
    t.datetime "created_at", null: false
    t.date "data", null: false
    t.string "email"
    t.integer "harmonizacoes", default: 0, null: false
    t.integer "mesa", null: false
    t.string "nome", null: false
    t.string "ocasiao"
    t.integer "pessoas", null: false
    t.text "restricoes"
    t.string "status", default: "confirmada", null: false
    t.string "telefone", null: false
    t.string "token", null: false
    t.string "turno", null: false
    t.datetime "updated_at", null: false
    t.index ["codigo"], name: "index_reservations_on_codigo", unique: true
    t.index ["data", "turno", "mesa"], name: "index_reservations_on_mesa_ocupada", unique: true, where: "status = 'confirmada'"
    t.index ["data", "turno"], name: "index_reservations_on_data_and_turno"
    t.index ["token"], name: "index_reservations_on_token", unique: true
  end
end
