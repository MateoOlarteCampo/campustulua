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

ActiveRecord::Schema.define(version: 20161205183845) do

  create_table "archives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.string   "file"
    t.integer  "course_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["course_id"], name: "index_archives_on_course_id", using: :btree
  end

  create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.text     "body",         limit: 65535
    t.string   "picture"
    t.integer  "user_id"
    t.integer  "visits_count",               default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["user_id"], name: "index_articles_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["article_id"], name: "index_comments_on_article_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "course_students", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.decimal  "calification", precision: 16, scale: 2, default: "0.0"
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.index ["course_id"], name: "index_course_students_on_course_id", using: :btree
    t.index ["user_id"], name: "index_course_students_on_user_id", using: :btree
  end

  create_table "courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.integer  "year"
    t.integer  "semester"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_courses_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "identification"
    t.string   "name"
    t.string   "last_name"
    t.string   "profile_picture"
    t.boolean  "activated",        default: false
    t.integer  "permission_level"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["identification"], name: "index_users_on_identification", unique: true, using: :btree
  end

  add_foreign_key "archives", "courses"
  add_foreign_key "articles", "users"
  add_foreign_key "comments", "articles"
  add_foreign_key "comments", "users"
  add_foreign_key "course_students", "courses"
  add_foreign_key "course_students", "users"
  add_foreign_key "courses", "users"
end
