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

ActiveRecord::Schema.define(version: 20141121142103) do

  create_table "passports", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "email"
    t.string   "mobile"
    t.string   "number"
    t.date     "expiry_date"
    t.string   "status",        default: "ready_to_start"
    t.string   "unique_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "passports", ["dob"], name: "index_passports_on_dob", using: :btree
  add_index "passports", ["email"], name: "index_passports_on_email", using: :btree
  add_index "passports", ["mobile"], name: "index_passports_on_mobile", using: :btree
  add_index "passports", ["number"], name: "index_passports_on_number", unique: true, using: :btree
  add_index "passports", ["status"], name: "index_passports_on_status", using: :btree
  add_index "passports", ["unique_number"], name: "index_passports_on_unique_number", unique: true, using: :btree

  create_table "static_pages", force: true do |t|
    t.string   "page_id"
    t.string   "name"
    t.text     "content"
    t.boolean  "active",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visas", force: true do |t|
    t.string   "status",        default: "under_process"
    t.string   "unique_number"
    t.string   "visa_type"
    t.boolean  "is_deleted",    default: false
    t.integer  "passport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
