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

ActiveRecord::Schema.define(version: 20160520193059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acceptance_criteria", force: :cascade do |t|
    t.integer "ticket_id"
    t.string  "description"
  end

  add_index "acceptance_criteria", ["ticket_id"], name: "index_acceptance_criteria_on_ticket_id", using: :btree

  create_table "apps", force: :cascade do |t|
    t.string "name"
    t.string "repository_name"
    t.string "repository_owner"
  end

  create_table "apps_users", force: :cascade do |t|
    t.integer "app_id"
    t.integer "user_id"
  end

  add_index "apps_users", ["app_id"], name: "index_apps_users_on_app_id", using: :btree
  add_index "apps_users", ["user_id"], name: "index_apps_users_on_user_id", using: :btree

  create_table "features", force: :cascade do |t|
    t.string  "title"
    t.integer "app_id"
  end

  add_index "features", ["app_id"], name: "index_features_on_app_id", using: :btree

  create_table "lanes", force: :cascade do |t|
    t.integer "app_id"
    t.string  "title"
  end

  add_index "lanes", ["app_id"], name: "index_lanes_on_app_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.string   "type"
    t.text     "description"
    t.integer  "requester_id"
    t.integer  "owner_id"
    t.string   "title"
    t.integer  "lane_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points"
  end

  add_index "tickets", ["lane_id"], name: "index_tickets_on_lane_id", using: :btree
  add_index "tickets", ["owner_id"], name: "index_tickets_on_owner_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "github_user_id", null: false
    t.string   "nickname",       null: false
    t.string   "email",          null: false
    t.string   "auth_token",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
