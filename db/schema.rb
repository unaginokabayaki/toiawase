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

ActiveRecord::Schema.define(version: 20191209114706) do

  create_table "issue_comment_likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "issue_comment_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["issue_comment_id"], name: "index_issue_comment_likes_on_issue_comment_id", using: :btree
    t.index ["user_id"], name: "index_issue_comment_likes_on_user_id", using: :btree
  end

  create_table "issue_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "issue_id"
    t.string   "comment"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_issue_comments_on_issue_id", using: :btree
    t.index ["user_id"], name: "index_issue_comments_on_user_id", using: :btree
  end

  create_table "issue_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "sort"
  end

  create_table "issues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_id"
    t.string   "product_feature"
    t.integer  "issue_type_id"
    t.string   "content"
    t.string   "solution"
    t.integer  "responder_id"
    t.string   "reporter_name"
    t.string   "site_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["issue_type_id"], name: "index_issues_on_issue_type_id", using: :btree
    t.index ["product_id"], name: "index_issues_on_product_id", using: :btree
    t.index ["responder_id"], name: "index_issues_on_responder_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "sort"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",            null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "mail"
    t.string   "profile"
    t.string   "image"
    t.string   "remember_token"
    t.index ["name"], name: "index_users_on_name", unique: true, using: :btree
  end

  add_foreign_key "issue_comment_likes", "issue_comments"
  add_foreign_key "issue_comment_likes", "users"
  add_foreign_key "issue_comments", "issues"
  add_foreign_key "issue_comments", "users"
  add_foreign_key "issues", "issue_types"
  add_foreign_key "issues", "products"
  add_foreign_key "issues", "users", column: "responder_id"
end
