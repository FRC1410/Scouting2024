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

ActiveRecord::Schema[7.1].define(version: 2024_01_15_032719) do
  create_table "actions", force: :cascade do |t|
    t.string "name"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "alliance_teams", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "alliance_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alliance_id"], name: "index_alliance_teams_on_alliance_id"
    t.index ["team_id"], name: "index_alliance_teams_on_team_id"
  end

  create_table "alliances", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "color", null: false
  end

  create_table "competitions", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_actions", force: :cascade do |t|
    t.integer "match_id", null: false
    t.integer "score_speaker"
    t.integer "score_amp"
    t.boolean "leave"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "score_speaker_auto", default: 0
    t.integer "score_amp_auto", default: 0
    t.integer "score_trap", default: 0
    t.index ["match_id"], name: "index_match_actions_on_match_id"
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "match_number"
    t.integer "red_alliance_id"
    t.integer "blue_alliance_id"
    t.index ["blue_alliance_id"], name: "index_matches_on_blue_alliance_id"
    t.index ["red_alliance_id"], name: "index_matches_on_red_alliance_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "alliances_id"
    t.decimal "alliance"
    t.text "team_type"
    t.text "location"
    t.text "logo"
    t.index ["alliances_id"], name: "index_teams_on_alliances_id"
  end

  add_foreign_key "alliance_teams", "alliances"
  add_foreign_key "alliance_teams", "teams"
  add_foreign_key "match_actions", "matches"
  add_foreign_key "matches", "alliances", column: "blue_alliance_id"
  add_foreign_key "matches", "alliances", column: "red_alliance_id"
end
