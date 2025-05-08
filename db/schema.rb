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

ActiveRecord::Schema[8.0].define(version: 2025_05_08_180609) do
  create_table "gifs", force: :cascade do |t|
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "global_rank"
    t.integer "rank_count"
    t.json "rankings_array", default: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  end

  create_table "rankings", force: :cascade do |t|
    t.integer "gif_id", null: false
    t.integer "user_id", null: false
    t.float "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gif_id"], name: "index_rankings_on_gif_id"
    t.index ["user_id"], name: "index_rankings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "rankings", "gifs"
  add_foreign_key "rankings", "users"
end
