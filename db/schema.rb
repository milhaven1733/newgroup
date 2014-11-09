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

ActiveRecord::Schema.define(version: 20141109005819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "et_groups", force: true do |t|
    t.string   "name"
    t.integer  "leader_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ticket_id"
    t.datetime "deadline"
    t.integer  "target_amount"
  end

  create_table "group_prices", force: true do |t|
    t.integer  "ticket_id"
    t.integer  "range_from"
    t.integer  "range_to"
    t.integer  "price_in_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "et_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amount"
    t.integer  "status",      default: 0
  end

  add_index "groups_users", ["et_group_id"], name: "index_groups_users_on_et_group_id", using: :btree
  add_index "groups_users", ["user_id"], name: "index_groups_users_on_user_id", using: :btree

  create_table "merchant_infos", force: true do |t|
    t.integer  "user_id"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "url"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "workday_opening_time"
    t.string   "sat_opening_time"
    t.string   "sun_opening_time"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "ticket_id"
    t.integer  "count"
    t.integer  "price_in_cents"
    t.integer  "amount_in_cents"
    t.integer  "status",            default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "will_call"
    t.integer  "shipping_in_cents"
  end

  create_table "tickets", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "desc"
    t.datetime "start_at"
    t.string   "image_url"
    t.integer  "oprice_in_cents"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "student_discount",    default: 0
    t.string   "city"
    t.integer  "shipping_in_cents"
    t.string   "sitting_map"
    t.integer  "minimum_amount"
    t.integer  "flat_discount"
    t.datetime "end_at"
    t.integer  "flat_price_in_cents"
    t.boolean  "will_call"
  end

  create_table "time_for_ticket_searches", force: true do |t|
    t.integer  "ticket_id"
    t.integer  "date"
    t.integer  "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: true do |t|
    t.string   "token"
    t.string   "customer_id"
    t.integer  "transaction_type", default: 0
    t.integer  "dollar_in_cents"
    t.integer  "status",           default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "user_id"
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "avatar"
    t.string   "phone"
    t.string   "address"
    t.integer  "role"
    t.boolean  "is_student"
    t.string   "zipcode"
    t.string   "genre"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  create_table "wallets", force: true do |t|
    t.integer  "user_id"
    t.integer  "balance_in_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
