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


ActiveRecord::Schema.define(version: 2020_02_25_145302) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "exhibitions", force: :cascade do |t|
    t.string "address_street"
    t.float "latitude"
    t.float "longitude"
    t.string "category"
    t.string "title"
    t.date "date_start"
    t.date "date_end"
    t.string "occurences"
    t.string "contact_url"
    t.string "address_name"
    t.string "contact_twitter"
    t.string "contact_phone"
    t.text "description"
    t.string "tags"
    t.string "contact_mail"
    t.string "lead_text"
    t.string "cover_url"
    t.string "contact_facebook"
    t.string "cover_credit"
    t.string "address_city"
    t.string "price_detail"
    t.string "price_type"
    t.string "date_description"
    t.string "address_zipcode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "external_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "visits_id", null: false
    t.bigint "users_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["users_id"], name: "index_messages_on_users_id"
    t.index ["visits_id"], name: "index_messages_on_visits_id"
  end

  create_table "participations", force: :cascade do |t|
    t.text "review_content"
    t.float "rating"
    t.date "date"
    t.boolean "interested"
    t.bigint "users_id", null: false
    t.bigint "exhibitions_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exhibitions_id"], name: "index_participations_on_exhibitions_id"
    t.index ["users_id"], name: "index_participations_on_users_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.boolean "subscribed"
    t.bigint "users_id", null: false
    t.bigint "visits_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["users_id"], name: "index_subscriptions_on_users_id"
    t.index ["visits_id"], name: "index_subscriptions_on_visits_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
    t.text "bio"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.date "date"
    t.text "information"
    t.bigint "exhibitions_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exhibitions_id"], name: "index_visits_on_exhibitions_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "messages", "users", column: "users_id"
  add_foreign_key "messages", "visits", column: "visits_id"
  add_foreign_key "participations", "exhibitions", column: "exhibitions_id"
  add_foreign_key "participations", "users", column: "users_id"
  add_foreign_key "subscriptions", "users", column: "users_id"
  add_foreign_key "subscriptions", "visits", column: "visits_id"
  add_foreign_key "visits", "exhibitions", column: "exhibitions_id"
end
