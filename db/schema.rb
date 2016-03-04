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

ActiveRecord::Schema.define(version: 20160302185715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "outdoor_alerts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.integer  "phone_id"
    t.string   "reason",      default: "general"
    t.integer  "poor",        default: 0
    t.integer  "low",         default: 0
    t.integer  "moderate",    default: 0
    t.integer  "fair",        default: 0
    t.integer  "excellent",   default: 0
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "outdoor_alerts", ["location_id"], name: "index_outdoor_alerts_on_location_id", using: :btree
  add_index "outdoor_alerts", ["phone_id"], name: "index_outdoor_alerts_on_phone_id", using: :btree
  add_index "outdoor_alerts", ["user_id"], name: "index_outdoor_alerts_on_user_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.string   "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "name"
    t.string   "nickname"
    t.string   "location"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "outdoor_alerts", "locations"
  add_foreign_key "outdoor_alerts", "phones"
  add_foreign_key "outdoor_alerts", "users"
end
