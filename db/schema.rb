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

ActiveRecord::Schema.define(version: 20150124133725) do

  create_table "attachments", force: true do |t|
    t.string  "file"
    t.string  "filename"
    t.string  "file_type"
    t.string  "attachable_type"
    t.integer "attachable_id"
    t.integer "source"
    t.integer "user_id"
  end

  create_table "biddings", force: true do |t|
    t.integer  "project_id"
    t.integer  "team_id"
    t.integer  "user_id"
    t.integer  "attachment_id"
    t.float    "price",         limit: 24
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "province_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: true do |t|
    t.integer  "from_user_id"
    t.text     "description"
    t.integer  "to_user_id"
    t.string   "email"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_attachments", force: true do |t|
    t.integer  "project_id"
    t.string   "attachment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_budgets", force: true do |t|
    t.integer  "project_id"
    t.integer  "kind"
    t.float    "price",      limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_tag_ships", force: true do |t|
    t.integer "project_id"
    t.integer "tag_id"
  end

  create_table "projects", force: true do |t|
    t.integer  "category_id"
    t.integer  "owner_id"
    t.integer  "attachment_id"
    t.string   "name"
    t.float    "budget",            limit: 24
    t.text     "description"
    t.datetime "dead_line"
    t.datetime "bidding_dead_line"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "budget_state"
  end

  create_table "provinces", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.string   "kind"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_team_ships", force: true do |t|
    t.integer "user_id"
    t.integer "team_id"
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
    t.string   "name"
    t.string   "login"
    t.string   "phone"
    t.string   "avatar"
    t.string   "qq_number"
    t.string   "pages"
    t.integer  "province_id"
    t.integer  "city_id"
    t.string   "github_login"
    t.string   "avatars"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
