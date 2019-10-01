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

ActiveRecord::Schema.define(version: 2019_07_29_200009) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collection_rules", force: :cascade do |t|
    t.integer "collection_id"
    t.string "search_attribute"
    t.string "rule_identifier"
    t.string "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collections", force: :cascade do |t|
    t.string "handle"
    t.string "title"
    t.string "sort_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shopify_collection_id"
    t.boolean "is_custom_collection", default: false
    t.boolean "disjunctive", default: true
  end

  create_table "collects", force: :cascade do |t|
    t.string "shopify_collection_id"
    t.string "shopify_product_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "filters", force: :cascade do |t|
    t.string "title"
    t.integer "position"
    t.integer "product_setting_id"
    t.integer "filter_type", default: 0
    t.index ["product_setting_id"], name: "index_filters_on_product_setting_id"
  end

  create_table "product_settings", force: :cascade do |t|
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_of_items_to_load"
    t.text "filter_order"
    t.boolean "include_out_of_stock_products", default: true
    t.boolean "related_search_on", default: true
    t.boolean "autoscroll_on", default: true
    t.string "load_more_text"
    t.boolean "overflow_scroll_on", default: true
    t.boolean "true_filter_on", default: true
    t.boolean "true_search_on", default: true
    t.boolean "filter_vendor_by_variant", default: true
    t.boolean "filter_product_type_by_variant", default: true
  end

  create_table "product_synonyms", force: :cascade do |t|
    t.string "synonym"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_setting_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.string "vendor"
    t.string "tags"
    t.string "first_image_url"
    t.string "second_image_url"
    t.float "price"
    t.float "compare_at_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shopify_id"
    t.string "product_type"
    t.datetime "shopify_created_at"
    t.integer "quantity"
    t.string "slug_url"
    t.string "colour"
    t.text "body_html"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "sizes", force: :cascade do |t|
    t.integer "product_id"
    t.string "title"
    t.integer "inventory_quantity"
    t.string "shopify_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_sizes_on_product_id"
  end

end
