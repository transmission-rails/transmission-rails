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

ActiveRecord::Schema.define(version: 20150331145012) do

  create_table "connections", force: :cascade do |t|
    t.string   "name"
    t.string   "host"
    t.integer  "port"
    t.string   "path"
    t.boolean  "ssl"
    t.string   "session_id"
    t.integer  "rpc_version"
    t.boolean  "credentials"
    t.string   "encrypted_username"
    t.string   "encrypted_password"
    t.integer  "users_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "username"
    t.string   "password_hash"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
