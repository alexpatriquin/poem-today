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

ActiveRecord::Schema.define(version: 20140427010003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "forecasts", force: true do |t|
    t.integer  "user_id"
    t.string   "summary"
    t.integer  "min_temp"
    t.integer  "max_temp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occasions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_numbers", force: true do |t|
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poem_occasions", force: true do |t|
    t.integer  "poem_id"
    t.integer  "occasion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poem_subjects", force: true do |t|
    t.integer  "poem_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poems", force: true do |t|
    t.string   "title"
    t.string   "first_line"
    t.text     "content"
    t.string   "poet"
    t.string   "isbn"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url"
  end

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.integer  "user_id"
    t.string   "text"
    t.string   "id_str"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_poems", force: true do |t|
    t.integer  "user_id"
    t.integer  "poem_id"
    t.integer  "match_score"
    t.string   "keyword_text"
    t.integer  "keyword_frequency"
    t.string   "keyword_source"
    t.string   "keyword_source_id"
    t.string   "match_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "summary"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.date     "birthday"
    t.string   "twitter_handle"
    t.string   "location"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
