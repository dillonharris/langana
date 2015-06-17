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

ActiveRecord::Schema.define(version: 20150611134339) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_number"
    t.string   "email"
    t.string   "password_digest"
    t.string   "profile_picture"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mobile_confirmation_token_digest"
    t.string   "mobile_token_salt"
    t.datetime "mobile_confirmation_sent_at"
    t.datetime "confirmed_at"
    t.string   "unconfirmed_mobile_number"
  end

  add_index "users", ["mobile_number"], name: "index_users_on_mobile_number", unique: true, using: :btree

  create_table "work_references", force: :cascade do |t|
    t.integer  "employer_user_id"
    t.integer  "worker_user_id"
    t.string   "work"
    t.text     "comment"
    t.integer  "rating"
    t.boolean  "recommend"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "work_references", ["employer_user_id"], name: "index_work_references_on_employer_user_id", using: :btree
  add_index "work_references", ["worker_user_id"], name: "index_work_references_on_worker_user_id", using: :btree

  add_foreign_key "work_references", "users", column: "employer_user_id", on_delete: :cascade
  add_foreign_key "work_references", "users", column: "worker_user_id", on_delete: :cascade
end
