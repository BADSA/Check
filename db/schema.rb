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

ActiveRecord::Schema.define(version: 20150609080515) do

  create_table "question_answers", force: true do |t|
    t.string   "choice"
    t.integer  "test_answer_id"
    t.integer  "question_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.text     "title"
    t.string   "type"
    t.string   "choice1"
    t.string   "choice2"
    t.string   "choice3"
    t.string   "choice4"
    t.string   "right_answer"
    t.integer  "test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["test_id"], name: "index_questions_on_test_id", using: :btree

  create_table "test_answers", force: true do |t|
    t.string   "status"
    t.integer  "score"
    t.integer  "user_id"
    t.integer  "test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "test_answers", ["test_id"], name: "index_test_answers_on_test_id", using: :btree
  add_index "test_answers", ["user_id"], name: "index_test_answers_on_user_id", using: :btree

  create_table "tests", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "begins_at"
    t.datetime "ends_at"
    t.integer  "questions_amount"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tests", ["user_id"], name: "index_tests_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "uid"
    t.string   "provider"
    t.boolean  "manager",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
