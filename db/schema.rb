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

ActiveRecord::Schema.define(version: 20170826072015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.integer "size_a"
    t.integer "size_b"
    t.integer "size_h"
    t.decimal "purchase_price", precision: 8, scale: 2
    t.integer "mark_up"
    t.decimal "price", precision: 8, scale: 2
    t.decimal "weight", precision: 8, scale: 2
    t.boolean "color_white"
    t.boolean "color_black"
    t.boolean "color_red"
    t.boolean "color_yellow"
    t.boolean "color_green"
    t.boolean "color_blue"
    t.boolean "color_violet"
    t.string "brand"
    t.boolean "material_plastic"
    t.boolean "material_iron"
    t.boolean "material_another"
    t.boolean "material_wooden"
    t.boolean "material_fabric"
    t.string "supplier"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "boys"
    t.boolean "girls"
    t.text "description"
    t.string "image"
    t.string "image_id"
    t.string "country"
    t.integer "discount"
    t.integer "product_code"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "number"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "username"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
