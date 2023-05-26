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

ActiveRecord::Schema[7.0].define(version: 2023_05_26_065728) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.string "address", null: false
    t.string "phone", null: false
  end

  create_table "product_orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "products_id", null: false
    t.bigint "orders_id", null: false
    t.integer "amount", null: false
    t.index ["orders_id"], name: "index_product_orders_on_orders_id"
    t.index ["products_id"], name: "index_product_orders_on_products_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.integer "balance", null: false
  end

  add_foreign_key "product_orders", "orders", column: "orders_id"
  add_foreign_key "product_orders", "products", column: "products_id"
end
