# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_15_004236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_products", force: :cascade do |t|
    t.bigint "cart_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_products_on_cart_id"
    t.index ["product_id"], name: "index_cart_products_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cash_on_deliveries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cash_on_delivery_details", force: :cascade do |t|
    t.integer "price"
    t.integer "more_than"
    t.bigint "cash_on_delivery_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cash_on_delivery_id"], name: "index_cash_on_delivery_details_on_cash_on_delivery_id"
  end

  create_table "delivery_prices", force: :cascade do |t|
    t.integer "price"
    t.integer "per"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delivery_time_details", force: :cascade do |t|
    t.string "time"
    t.bigint "delivery_time_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_time_id"], name: "index_delivery_time_details_on_delivery_time_id"
  end

  create_table "delivery_times", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_details", force: :cascade do |t|
    t.integer "price"
    t.integer "quantity"
    t.bigint "order_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.date "delivery_date"
    t.integer "total_with_tax"
    t.bigint "cash_on_delivery_id"
    t.bigint "delivery_price_id"
    t.bigint "tax_id"
    t.bigint "user_id"
    t.bigint "delivery_time_detail_id"
    t.bigint "shipping_address_id"
    t.bigint "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_orders_on_cart_id"
    t.index ["cash_on_delivery_id"], name: "index_orders_on_cash_on_delivery_id"
    t.index ["delivery_price_id"], name: "index_orders_on_delivery_price_id"
    t.index ["delivery_time_detail_id"], name: "index_orders_on_delivery_time_detail_id"
    t.index ["shipping_address_id"], name: "index_orders_on_shipping_address_id"
    t.index ["tax_id"], name: "index_orders_on_tax_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "image"
    t.integer "price", null: false
    t.text "description"
    t.boolean "published", default: true, null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.string "full_name"
    t.string "post"
    t.string "tel"
    t.string "address"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shipping_addresses_on_user_id"
  end

  create_table "taxes", force: :cascade do |t|
    t.decimal "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cart_products", "carts"
  add_foreign_key "cart_products", "products"
  add_foreign_key "cash_on_delivery_details", "cash_on_deliveries"
  add_foreign_key "delivery_time_details", "delivery_times"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "products"
  add_foreign_key "orders", "carts"
  add_foreign_key "orders", "cash_on_deliveries"
  add_foreign_key "orders", "delivery_prices"
  add_foreign_key "orders", "delivery_time_details"
  add_foreign_key "orders", "shipping_addresses"
  add_foreign_key "orders", "taxes"
  add_foreign_key "orders", "users"
  add_foreign_key "shipping_addresses", "users"
end
