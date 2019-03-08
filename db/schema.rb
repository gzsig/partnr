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

ActiveRecord::Schema.define(version: 2019_03_07_183549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "goods", force: :cascade do |t|
    t.string "brand"
    t.string "model"
    t.integer "model_year"
    t.integer "fabrication_year"
    t.string "serial_number"
    t.string "licens_plate"
    t.string "kilometers"
    t.string "price"
    t.string "color"
    t.string "facts"
    t.string "version"
    t.string "good_type"
    t.string "photo_one"
    t.string "photo_two"
    t.string "photo_three"
    t.string "photo_four"
    t.string "video"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: false
    t.string "body_style"
    t.string "clicksign_key"
  end

  create_table "partners", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "good_id"
    t.boolean "track_use"
    t.boolean "other_drivers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "none_of_the_above"
    t.integer "step", default: 0
    t.string "request_signature_key"
    t.integer "numberber_of_passengers"
    t.integer "km_month"
    t.integer "frenquency_month"
    t.boolean "for_work"
    t.index ["good_id"], name: "index_partners_on_good_id"
    t.index ["user_id"], name: "index_partners_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.text "bio"
    t.string "phone_number"
    t.string "CPF"
    t.string "occupation"
    t.string "address"
    t.boolean "adm", default: false
    t.string "profile_picture"
    t.string "favorite"
    t.string "clicksign_key"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "partners", "goods"
  add_foreign_key "partners", "users"
end
