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

ActiveRecord::Schema[7.1].define(version: 2024_01_12_162219) do
  create_table "actions", force: :cascade do |t|
    t.string "name"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alliances", force: :cascade do |t|
    t.string "name"
    t.integer "competition_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_id"], name: "index_alliances_on_competition_id"
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
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.integer "alliance_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alliance_id"], name: "index_teams_on_alliance_id"
  end

  add_foreign_key "alliances", "competitions"
  add_foreign_key "match_actions", "matches"
  add_foreign_key "teams", "alliances"
end
