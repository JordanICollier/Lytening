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

ActiveRecord::Schema.define(version: 20150609170330) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bugs", force: :cascade do |t|
    t.string "title"
    t.text   "description"
  end

  create_table "comments", force: :cascade do |t|
    t.string  "body"
    t.integer "stryke_id"
    t.integer "spark_count"
    t.integer "user_id"
    t.string  "body_html"
  end

  create_table "followings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "follower_id"
  end

  create_table "sparks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "sparkable_id"
    t.string  "sparkable_type"
  end

  add_index "sparks", ["sparkable_type", "sparkable_id"], name: "index_sparks_on_sparkable_type_and_sparkable_id", using: :btree

  create_table "strykes", force: :cascade do |t|
    t.string   "body"
    t.string   "image_url"
    t.string   "image"
    t.integer  "spark_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "body_html"
  end

  add_index "strykes", ["created_at"], name: "index_strykes_on_created_at", using: :btree
  add_index "strykes", ["spark_count"], name: "index_strykes_on_spark_count", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "avatar"
    t.string   "location"
    t.string   "work"
    t.string   "school"
    t.datetime "birthday"
    t.string   "gender"
    t.string   "interest"
    t.text     "about"
    t.integer  "spark_count"
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
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.integer  "setup_step"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
