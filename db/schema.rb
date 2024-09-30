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

ActiveRecord::Schema[7.0].define(version: 2022_05_04_131132) do
  create_table "participations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_participations_on_topic_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "state_relations", force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "generation", default: 0, null: false
    t.index ["ancestor_id"], name: "index_state_relations_on_ancestor_id"
    t.index ["descendant_id"], name: "index_state_relations_on_descendant_id"
  end

  create_table "states", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0, null: false
    t.integer "view", default: 0, null: false
    t.integer "topic_id", null: false
    t.integer "owner_id"
    t.index ["owner_id"], name: "index_states_on_owner_id"
    t.index ["topic_id"], name: "index_states_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "image", default: "0.jpg", null: false
    t.integer "view", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
    t.index ["owner_id"], name: "index_topics_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "participations", "topics"
  add_foreign_key "participations", "users"
  add_foreign_key "state_relations", "states", column: "ancestor_id"
  add_foreign_key "state_relations", "states", column: "descendant_id"
  add_foreign_key "states", "topics"
  add_foreign_key "states", "users", column: "owner_id"
  add_foreign_key "topics", "users", column: "owner_id"
end
