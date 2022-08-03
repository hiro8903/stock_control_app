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

ActiveRecord::Schema[7.0].define(version: 2022_08_03_095656) do
  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_departments_on_name"
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_manufacturers_on_name", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.integer "paint_id", null: false
    t.integer "user_id", null: false
    t.datetime "order_on", null: false
    t.float "quantity", null: false
    t.datetime "desired_on"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paint_id"], name: "index_orders_on_paint_id", unique: true
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "paints", force: :cascade do |t|
    t.string "name", null: false
    t.integer "manufacturer_id", null: false
    t.float "unit_price"
    t.float "ordering_point"
    t.string "main_ingredient"
    t.integer "warranty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "discontinue", default: false
    t.index ["manufacturer_id"], name: "index_paints_on_manufacturer_id"
    t.index ["name"], name: "index_paints_on_name", unique: true
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_suppliers_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "department_id"
    t.index ["department_id"], name: "index_users_on_department_id"
  end

  add_foreign_key "orders", "paints"
  add_foreign_key "orders", "users"
  add_foreign_key "paints", "manufacturers"
  add_foreign_key "users", "departments"
end
