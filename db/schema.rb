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

ActiveRecord::Schema[7.1].define(version: 2024_02_21_010129) do
  create_table "alliances", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "color", null: false
    t.integer "match_id"
    t.index ["match_id"], name: "index_alliances_on_match_id"
  end

  create_table "competition_teams", force: :cascade do |t|
    t.integer "competition_id"
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_id"], name: "index_competition_teams_on_competition_id"
    t.index ["team_id"], name: "index_competition_teams_on_team_id"
  end

  create_table "competitions", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "match_number"
    t.integer "competition_id", default: 11, null: false
    t.index ["competition_id"], name: "index_matches_on_competition_id"
  end

  create_table "team_logs", force: :cascade do |t|
    t.text "log"
    t.integer "team_id", null: false
    t.integer "alliance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_score_sheet_id"
    t.index ["alliance_id"], name: "index_team_logs_on_alliance_id"
    t.index ["team_id"], name: "index_team_logs_on_team_id"
    t.index ["team_score_sheet_id"], name: "index_team_logs_on_team_score_sheet_id"
  end

  create_table "team_score_sheets", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "alliance_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "leave", default: false
    t.integer "score_speaker_auto", default: 0
    t.integer "score_amp_auto", default: 0
    t.integer "score_speaker", default: 0
    t.integer "score_amp", default: 0
    t.integer "score_trap", default: 0
    t.boolean "park", default: false
    t.boolean "onstage", default: false
    t.integer "score_speaker_amplified", default: 0
    t.integer "foul", default: 0
    t.boolean "defended", default: false
    t.boolean "dead_on_field", default: false
    t.integer "user_id"
    t.boolean "currently_locked", default: false
    t.boolean "scouting_complete", default: false
    t.integer "score_harmony", default: 0
    t.index ["alliance_id"], name: "index_team_score_sheets_on_alliance_id"
    t.index ["team_id"], name: "index_team_score_sheets_on_team_id"
    t.index ["user_id"], name: "index_team_score_sheets_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "team_type"
    t.text "location"
    t.text "logo"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "initials"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "alliances", "matches"
  add_foreign_key "competition_teams", "competitions"
  add_foreign_key "competition_teams", "teams"
  add_foreign_key "matches", "competitions"
  add_foreign_key "team_logs", "alliances"
  add_foreign_key "team_logs", "teams"
  add_foreign_key "team_score_sheets", "alliances"
  add_foreign_key "team_score_sheets", "teams"
  add_foreign_key "team_score_sheets", "users"
end
