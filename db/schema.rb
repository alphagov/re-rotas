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

ActiveRecord::Schema.define(version: 2019_07_31_081757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "uuid-ossp"

  create_table "annual_leave_events", force: :cascade do |t|
    t.string "email"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manual_calendar_events", force: :cascade do |t|
    t.string "manual_calendar_id"
    t.date "start_date"
    t.date "end_date"
    t.string "emails", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "emails_text"
  end

  create_table "manual_calendars", id: false, force: :cascade do |t|
    t.string "id"
    t.string "name"
    t.bigint "team_id"
    t.string "clock_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_manual_calendars_on_team_id"
  end

  create_table "pager_duty_calendars", id: false, force: :cascade do |t|
    t.string "id"
    t.bigint "team_id"
    t.string "name"
    t.string "url"
    t.string "clock_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_pager_duty_calendars_on_team_id"
  end

  create_table "spatial_ref_sys", primary_key: "srid", id: :integer, default: nil, force: :cascade do |t|
    t.string "auth_name", limit: 256
    t.integer "auth_srid"
    t.string "srtext", limit: 2048
    t.string "proj4text", limit: 2048
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description", default: ""
    t.string "slug"
  end

  add_foreign_key "manual_calendars", "teams"
  add_foreign_key "pager_duty_calendars", "teams"
end
