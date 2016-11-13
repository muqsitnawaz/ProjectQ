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

ActiveRecord::Schema.define(version: 20160811081618) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.string   "content",                     null: false
    t.boolean  "anonymous",   default: false
    t.integer  "upvotes",     default: 0
    t.integer  "downvotes",   default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["user_id"], name: "index_answers_on_user_id"

  create_table "article_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "topics"
    t.string   "heading"
    t.string   "explanation"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "article_requests", ["user_id"], name: "index_article_requests_on_user_id"

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

  add_index "articles", ["user_id"], name: "index_articles_on_user_id"

  create_table "cause_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "cause_id"
    t.string   "content",                    null: false
    t.boolean  "anonymous",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "cause_comments", ["cause_id"], name: "index_cause_comments_on_cause_id"
  add_index "cause_comments", ["user_id"], name: "index_cause_comments_on_user_id"

  create_table "cause_replies", force: :cascade do |t|
    t.integer  "cause_comment_id"
    t.integer  "user_id"
    t.string   "content",                          null: false
    t.boolean  "anonymous",        default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "cause_replies", ["cause_comment_id"], name: "index_cause_replies_on_cause_comment_id"
  add_index "cause_replies", ["user_id"], name: "index_cause_replies_on_user_id"

  create_table "causes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "cause_type"
    t.string   "intro"
    t.string   "detail"
    t.string   "whymatters"
    t.string   "image"
    t.string   "category"
    t.string   "howhelp"
    t.string   "totalpeople"
    t.boolean  "pledge"
    t.string   "pledgeTo"
    t.string   "pledgeStep"
    t.datetime "pledgeDate"
    t.string   "petitionTo"
    t.boolean  "dont_pledge"
    t.integer  "total_pledges",  default: 0
    t.integer  "total_signs",    default: 0
    t.string   "petition_help"
    t.datetime "petitiondate"
    t.integer  "petition_signs", default: 0
    t.boolean  "anonymous",      default: false
    t.text     "followers",      default: "--- []\n"
    t.integer  "num_agree",      default: 0
    t.integer  "num_disagree",   default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "causes", ["user_id"], name: "index_causes_on_user_id"

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "contest_answers", force: :cascade do |t|
    t.integer  "contest_id"
    t.integer  "user_id"
    t.string   "answer",                     null: false
    t.string   "image"
    t.boolean  "is_winner",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "contest_answers", ["contest_id"], name: "index_contest_answers_on_contest_id"
  add_index "contest_answers", ["user_id"], name: "index_contest_answers_on_user_id"

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

  add_index "contests", ["user_id"], name: "index_contests_on_user_id"

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "poster_id"
    t.string   "resource_type"
    t.integer  "notification_type"
    t.integer  "resource_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "questions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "content",                         null: false
    t.string   "detail"
    t.boolean  "anonymous",  default: false
    t.integer  "views",      default: 0
    t.text     "topics",     default: "--- []\n"
    t.text     "followers",  default: "--- []\n"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "replies", force: :cascade do |t|
    t.integer  "answer_id"
    t.integer  "user_id"
    t.string   "content",                    null: false
    t.boolean  "anonymous",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "replies", ["answer_id"], name: "index_replies_on_answer_id"
  add_index "replies", ["user_id"], name: "index_replies_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "profile_pic"
    t.string   "name",                   default: "",         null: false
    t.boolean  "is_admin",               default: false
    t.boolean  "completed",              default: false
    t.text     "education",              default: "--- []\n"
    t.text     "interests",              default: "--- []\n"
    t.text     "knows_about",            default: "--- []\n"
    t.text     "employments",            default: "--- []\n"
    t.string   "location",               default: ""
    t.text     "answers_upvote",         default: "--- []\n"
    t.text     "answers_downvote",       default: "--- []\n"
    t.text     "following",              default: "--- []\n"
    t.text     "causes_agreed",          default: "--- []\n"
    t.text     "causes_disagreed",       default: "--- []\n"
    t.text     "causes_followed",        default: "--- []\n"
    t.boolean  "read",                   default: true
    t.integer  "profile_views",          default: 0
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

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
