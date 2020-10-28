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

ActiveRecord::Schema.define(version: 2020_10_18_003854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["email"], name: "index_attendees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_attendees_on_reset_password_token", unique: true
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "workshop_id", null: false
    t.bigint "attendee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attendee_id"], name: "index_enrollments_on_attendee_id"
    t.index ["workshop_id"], name: "index_enrollments_on_workshop_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workshop_contents", force: :cascade do |t|
    t.bigint "workshop_id", null: false
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workshop_id"], name: "index_workshop_contents_on_workshop_id"
  end

  create_table "workshops", force: :cascade do |t|
    t.string "name"
    t.string "short_description"
    t.text "full_description"
    t.integer "attendees"
    t.integer "duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "workshop_date"
    t.time "start_time"
    t.integer "status", default: 0
  end

  add_foreign_key "enrollments", "attendees"
  add_foreign_key "enrollments", "workshops"
  add_foreign_key "workshop_contents", "workshops"
end
