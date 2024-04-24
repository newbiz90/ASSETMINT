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

ActiveRecord::Schema[7.1].define(version: 2024_04_24_073941) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "news_snippets", force: :cascade do |t|
    t.text "content"
    t.bigint "ticker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "article_url"
    t.jsonb "keywords"
    t.jsonb "tickers"
    t.string "publisher_logo_url"
    t.string "publisher_name"
    t.index ["ticker_id"], name: "index_news_snippets_on_ticker_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "subscribable_type", null: false
    t.bigint "subscribable_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscribable_type", "subscribable_id"], name: "index_subscriptions_on_subscribable"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "tickers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tickers_on_name"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "flow"
    t.date "txndate"
    t.decimal "txnprice"
    t.decimal "qty"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_ticker_id"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_transactions_on_user_id"
    t.index ["user_ticker_id"], name: "index_transactions_on_user_ticker_id"
  end

  create_table "user_tickers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ticker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticker_id"], name: "index_user_tickers_on_ticker_id"
    t.index ["user_id"], name: "index_user_tickers_on_user_id"
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

  add_foreign_key "news_snippets", "tickers"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "transactions", "user_tickers"
  add_foreign_key "transactions", "users"
  add_foreign_key "user_tickers", "tickers"
  add_foreign_key "user_tickers", "users"
end
