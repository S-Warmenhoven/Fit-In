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

ActiveRecord::Schema.define(version: 2020_02_27_082546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "class_schedules", force: :cascade do |t|
    t.string "title"
    t.string "day_of_week"
    t.time "start_time"
    t.time "end_time"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_class_schedules_on_user_id"
  end

  create_table "social_events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "when"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_social_events_on_user_id"
  end

  create_table "trainers", force: :cascade do |t|
    t.string "image_url"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_trainers_on_user_id"
  end

  create_table "user_workouts", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.bigint "user_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_workouts_on_user_id"
    t.index ["workout_id"], name: "index_user_workouts_on_workout_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "program"
    t.integer "meals"
    t.decimal "food_account"
    t.string "role"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "workouts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "class_schedules", "users"
  add_foreign_key "social_events", "users"
  add_foreign_key "trainers", "users"
  add_foreign_key "user_workouts", "users"
  add_foreign_key "user_workouts", "workouts"
  add_foreign_key "workouts", "users"
end
