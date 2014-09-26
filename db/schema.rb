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

ActiveRecord::Schema.define(version: 20140831212249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: true do |t|
    t.integer  "user_id"
    t.string   "industry"
    t.string   "job_title"
    t.text     "bio"
    t.string   "location"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employers", force: true do |t|
    t.integer  "user_id"
    t.string   "company"
    t.string   "industry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "employer_id"
    t.string   "industry"
    t.decimal  "wage"
    t.string   "job_title"
    t.date     "start_date"
    t.date     "end_date"
    t.time     "start_time"
    t.time     "end_time"
    t.text     "description"
    t.string   "location"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.boolean  "expiration_status", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "linkedin_id"
    t.string   "facebook_id"
    t.string   "user_type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "industry"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
