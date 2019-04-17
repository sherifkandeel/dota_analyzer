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

ActiveRecord::Schema.define(version: 2019_04_10_182549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crono_jobs", force: :cascade do |t|
    t.string "job_id", null: false
    t.text "log"
    t.datetime "last_performed_at"
    t.boolean "healthy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_crono_jobs_on_job_id", unique: true
  end

  create_table "heros", force: :cascade do |t|
    t.string "name"
    t.integer "herald_pick"
    t.integer "herald_win"
    t.integer "guardian_pick"
    t.integer "guardian_win"
    t.integer "crusader_pick"
    t.integer "crusader_win"
    t.integer "archon_pick"
    t.integer "archon_win"
    t.integer "legend_pick"
    t.integer "legend_win"
    t.integer "ancient_pick"
    t.integer "ancient_win"
    t.integer "divine_pick"
    t.integer "divine_win"
    t.integer "immortal_pick"
    t.integer "immortal_ban"
    t.integer "immortal_win"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_heros_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "nickname"
    t.string "avatar_url"
    t.string "profile_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

end
