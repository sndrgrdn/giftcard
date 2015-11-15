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

ActiveRecord::Schema.define(version: 20151115100920) do

  create_table "cards", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.decimal  "value"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code",       limit: 255
    t.string   "scnd_code",  limit: 255
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "url",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "product",       limit: 255
    t.string   "price",         limit: 255
    t.string   "product_id",    limit: 255
    t.string   "image",         limit: 255
    t.string   "product_url",   limit: 255
    t.string   "product_title", limit: 255
  end

end
