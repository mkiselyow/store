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

ActiveRecord::Schema.define(version: 20171127130030) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_category_id"
    t.integer "parent_subcategory_id"
  end

  create_table "category_posts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "comment_posts", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id"
    t.bigint "useful_article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["useful_article_id"], name: "index_comment_posts_on_useful_article_id"
    t.index ["user_id"], name: "index_comment_posts_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id"
    t.integer "rating", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "image_products", force: :cascade do |t|
    t.string "image"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_image_products_on_product_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1
    t.bigint "order_id"
    t.index ["cart_id"], name: "index_line_items_on_cart_id"
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "number"
    t.text "comment"
    t.string "city"
    t.integer "post_office_number"
    t.string "pay_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.integer "size_a"
    t.integer "size_b"
    t.integer "size_h"
    t.decimal "purchase_price", precision: 8, scale: 2
    t.integer "mark_up", default: 0
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
    t.integer "discount", default: 0
    t.integer "product_code"
    t.integer "times_viewed", default: 1
    t.bigint "category_id"
    t.string "other_desc"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "shares", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "poster"
    t.bigint "user_id"
    t.date "start_share"
    t.date "end_share"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shares_on_user_id"
  end

  create_table "useful_articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "preview"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published", default: false
    t.integer "category_id"
    t.index ["user_id"], name: "index_useful_articles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "number"
    t.boolean "admin", default: false
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
    t.boolean "banned", default: false
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comment_posts", "useful_articles"
  add_foreign_key "comment_posts", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "image_products", "products"
  add_foreign_key "line_items", "carts"
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "shares", "users"
  add_foreign_key "useful_articles", "users"
end
