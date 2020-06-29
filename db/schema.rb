# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_29_131902) do

  create_table "annual_leave_events", force: :cascade do |t|
    t.string "email"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "audit_events", force: :cascade do |t|
    t.string "email"
    t.text "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manual_calendar_events", force: :cascade do |t|
    t.string "manual_calendar_id"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "emails"
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

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "spatial_ref_sys", primary_key: "srid", force: :cascade do |t|
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

end
