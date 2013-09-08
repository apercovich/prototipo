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

ActiveRecord::Schema.define(version: 20130908235032) do

  create_table "logs", force: true do |t|
    t.datetime "date"
    t.string   "action"
    t.text     "description"
    t.integer  "record_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logs", ["record_id"], name: "index_logs_on_record_id", using: :btree
  add_index "logs", ["user_id"], name: "index_logs_on_user_id", using: :btree

  create_table "records", force: true do |t|
    t.date     "date"
    t.time     "time_start"
    t.time     "time_end"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "records", ["user_id"], name: "index_records_on_user_id", using: :btree

  create_table "routes", force: true do |t|
    t.string   "pageName"
    t.datetime "date"
    t.string   "type"
    t.integer  "minutes"
    t.integer  "previous_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "routes", ["previous_id"], name: "index_routes_on_previous_id", using: :btree
  add_index "routes", ["user_id"], name: "index_routes_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "role"
    t.boolean  "active"
    t.boolean  "enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
