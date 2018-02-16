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

ActiveRecord::Schema.define(version: 20180209173603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "receiver_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "conversations", ["author_id", "receiver_id"], name: "index_conversations_on_author_id_and_receiver_id", unique: true, using: :btree
  add_index "conversations", ["author_id"], name: "index_conversations_on_author_id", using: :btree

  create_table "deposit_paids", force: :cascade do |t|
    t.integer  "project_id"
    t.float    "amount"
    t.string   "transaction_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "paid_status"
  end

  add_index "deposit_paids", ["project_id"], name: "index_deposit_paids_on_project_id", using: :btree

  create_table "feature_payments", force: :cascade do |t|
    t.integer  "project_milestone_id"
    t.float    "amount"
    t.string   "transaction_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "project_id"
  end

  add_index "feature_payments", ["project_id"], name: "index_feature_payments_on_project_id", using: :btree
  add_index "feature_payments", ["project_milestone_id"], name: "index_feature_payments_on_project_milestone_id", using: :btree

  create_table "personal_messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "personal_messages", ["conversation_id"], name: "index_personal_messages_on_conversation_id", using: :btree
  add_index "personal_messages", ["user_id"], name: "index_personal_messages_on_user_id", using: :btree


  create_table "feature_prices", force: :cascade do |t|
    t.string   "service_feature_name"
    t.float    "amount"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "pf_payment_id"
    t.string   "payment_status"
    t.string   "item_name"
    t.integer  "amount_gross"
    t.integer  "amount_fee"
    t.integer  "amount_net"
    t.integer  "merchant_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "project_id"
  end

  add_index "payments", ["project_id"], name: "index_payments_on_project_id"


  create_table "project_milestones", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "milestone_id"
    t.string   "avatar_url"
    t.string   "state"
    t.integer  "user_id"
  end

  add_index "project_milestones", ["project_id"], name: "index_project_milestones_on_project_id", using: :btree
  add_index "project_milestones", ["user_id"], name: "index_project_milestones_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "repo_id"
    t.string   "repo_name"
    t.string   "repo_description"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "branches_count"
    t.string   "issues_count"
    t.string   "closed_issues_count"
    t.string   "project_solution_to_problem"
    t.string   "project_expectation"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.integer  "role"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "deposit_paids", "projects"
  add_foreign_key "feature_payments", "project_milestones"
  add_foreign_key "feature_payments", "projects"
  add_foreign_key "personal_messages", "conversations"
  add_foreign_key "personal_messages", "users"
  add_foreign_key "project_milestones", "projects"
  add_foreign_key "project_milestones", "users"
  add_foreign_key "projects", "users"
end
