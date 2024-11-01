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

ActiveRecord::Schema.define(version: 2024_11_01_020343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.float "total"
    t.float "discount_total"
    t.boolean "purchased", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "coupon_id"
    t.bigint "user_id", null: false
    t.index ["coupon_id"], name: "index_carts_on_coupon_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "coupon_books", force: :cascade do |t|
    t.string "title"
    t.integer "max_number_of_coupons"
    t.integer "max_coupons_per_user"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string "title"
    t.string "code"
    t.boolean "redeemed", default: false
    t.float "discount_percentage"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "coupon_book_id", null: false
    t.index ["coupon_book_id"], name: "index_coupons_on_coupon_book_id"
    t.index ["user_id"], name: "index_coupons_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "username"
    t.string "email"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "products"
  add_foreign_key "carts", "coupons"
  add_foreign_key "carts", "users"
  add_foreign_key "coupons", "coupon_books"
  add_foreign_key "coupons", "users"
end
