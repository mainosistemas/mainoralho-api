# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_09_02_153917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_projects_on_owner_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "sprint_id", null: false
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sprint_id"], name: "index_rooms_on_sprint_id"
  end

  create_table "sprints", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "project_id"
    t.index ["owner_id"], name: "index_sprints_on_owner_id"
    t.index ["project_id"], name: "index_sprints_on_project_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "sprint_id", null: false
    t.bigint "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status_votation"
    t.datetime "start_votation_time", precision: 6
    t.datetime "finish_votation_time", precision: 6
    t.datetime "limit_votation_time", precision: 6
    t.integer "trend_vote"
    t.index ["owner_id"], name: "index_tasks_on_owner_id"
    t.index ["sprint_id"], name: "index_tasks_on_sprint_id"
  end

  create_table "user_votes", force: :cascade do |t|
    t.integer "score", null: false
    t.bigint "owner_id"
    t.bigint "task_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "voted_moment_time", precision: 6
    t.index ["owner_id"], name: "index_user_votes_on_owner_id"
    t.index ["task_id"], name: "index_user_votes_on_task_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.bigint "room_id"
    t.index ["room_id"], name: "index_users_on_room_id"
  end

  add_foreign_key "projects", "users", column: "owner_id"
  add_foreign_key "rooms", "sprints"
  add_foreign_key "sprints", "projects"
  add_foreign_key "sprints", "users", column: "owner_id"
  add_foreign_key "tasks", "sprints"
  add_foreign_key "tasks", "users", column: "owner_id"
  add_foreign_key "user_votes", "tasks"
  add_foreign_key "user_votes", "users", column: "owner_id"
  add_foreign_key "users", "rooms"
end
