# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160712190128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.string   "answer",                  null: false
    t.string   "image"
    t.integer  "upvotes",     default: 0
    t.integer  "downvotes",   default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "article_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "topics"
    t.string   "heading"
    t.string   "explanation"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "article_requests", ["user_id"], name: "index_article_requests_on_user_id", using: :btree

  create_table "articles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "article_request_id", default: -1
    t.string   "heading"
    t.string   "intro"
    t.string   "content"
    t.text     "topics",             default: "--- []\n"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "cause_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "cause_id"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cause_comments", ["cause_id"], name: "index_cause_comments_on_cause_id", using: :btree
  add_index "cause_comments", ["user_id"], name: "index_cause_comments_on_user_id", using: :btree

  create_table "causes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "cause_type"
    t.string   "intro"
    t.string   "detail"
    t.string   "whymatters"
    t.string   "image"
    t.text     "followers",    default: "--- []\n"
    t.integer  "num_agree",    default: 0
    t.integer  "num_disagree", default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "causes", ["user_id"], name: "index_causes_on_user_id", using: :btree

  create_table "contest_answers", force: :cascade do |t|
    t.integer  "contest_id"
    t.integer  "user_id"
    t.string   "answer",                     null: false
    t.string   "image"
    t.boolean  "is_winner",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "contest_answers", ["contest_id"], name: "index_contest_answers_on_contest_id", using: :btree
  add_index "contest_answers", ["user_id"], name: "index_contest_answers_on_user_id", using: :btree

  create_table "contests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "prize",                              null: false
    t.string   "status",        default: "open"
    t.string   "content",                            null: false
    t.string   "detail",                             null: false
    t.string   "image"
    t.text     "topics",        default: "--- []\n"
    t.date     "end_date"
    t.boolean  "winner_chosen", default: false
    t.integer  "winner_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "contests", ["user_id"], name: "index_contests_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notification_type"
    t.integer  "question_id"
    t.integer  "poster_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "content",                         null: false
    t.string   "detail",                          null: false
    t.string   "image"
    t.text     "topics",     default: "--- []\n"
    t.text     "followers",  default: "--- []\n"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "replies", force: :cascade do |t|
    t.integer  "answer_id"
    t.integer  "user_id"
    t.string   "reply",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "replies", ["answer_id"], name: "index_replies_on_answer_id", using: :btree
  add_index "replies", ["user_id"], name: "index_replies_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "",         null: false
    t.boolean  "is_admin",               default: false
    t.text     "education",              default: "--- []\n"
    t.text     "interests",              default: "--- []\n"
    t.text     "employments",            default: "--- []\n"
    t.string   "location",               default: ""
    t.text     "following",              default: "--- []\n"
    t.text     "causes_agreed",          default: "--- []\n"
    t.text     "causes_disagreed",       default: "--- []\n"
    t.text     "causes_followed",        default: "--- []\n"
    t.string   "email",                  default: "",         null: false
    t.string   "encrypted_password",     default: "",         null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
