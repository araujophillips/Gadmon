# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160213044348) do

  create_table "customers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.string   "username",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "comment",    limit: 255
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id",          limit: 4
    t.integer  "product_id",        limit: 4
    t.integer  "price_id",          limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "product_detail_id", limit: 4
    t.decimal  "comission",                   precision: 10
  end

  create_table "order_status_details", force: :cascade do |t|
    t.integer  "status_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "order_id",   limit: 4
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "paid"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "customer_id",                limit: 4
    t.decimal  "subtotal",                               precision: 10
    t.decimal  "tax",                                    precision: 10
    t.decimal  "total",                                  precision: 10
    t.integer  "invoice",                    limit: 4
    t.integer  "shipping_id",                limit: 4
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.decimal  "comission",                              precision: 10
    t.string   "comment",                    limit: 255
    t.string   "invoice_image_file_name",    limit: 255
    t.string   "invoice_image_content_type", limit: 255
    t.integer  "invoice_image_file_size",    limit: 4
    t.datetime "invoice_image_updated_at"
  end

  create_table "prices", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.decimal  "price",                  precision: 10
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "comment",    limit: 255
  end

  create_table "product_details", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.string   "serial",     limit: 255
    t.string   "comment",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "status",     limit: 4
  end

  create_table "product_statuses", force: :cascade do |t|
    t.boolean  "available"
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "published"
  end

  create_table "provider_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "providers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "type_id",    limit: 4
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.string   "address",    limit: 255
    t.string   "rif",        limit: 255
    t.string   "comment",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "purchase_details", force: :cascade do |t|
    t.integer  "purchase_id", limit: 4
    t.integer  "line",        limit: 4
    t.string   "name",        limit: 255
    t.decimal  "price",                   precision: 10
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "provider_id",                limit: 4
    t.decimal  "subtotal",                               precision: 10
    t.decimal  "tax",                                    precision: 10
    t.decimal  "total",                                  precision: 10
    t.integer  "invoice",                    limit: 4
    t.string   "comment",                    limit: 255
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.string   "invoice_image_file_name",    limit: 255
    t.string   "invoice_image_content_type", limit: 255
    t.integer  "invoice_image_file_size",    limit: 4
    t.datetime "invoice_image_updated_at"
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.boolean  "office"
    t.string   "company",      limit: 255
    t.string   "address",      limit: 255
    t.string   "municipality", limit: 255
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "comment",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "customer_id",  limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "password",   limit: 255
    t.integer  "level",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
