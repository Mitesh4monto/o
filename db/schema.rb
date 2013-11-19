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
# It's strongly recommended to check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20131118014256) do
=======
ActiveRecord::Schema.define(:version => 20131117205110) do
>>>>>>> dcc05d65dd23d3e8b8d3ce2b4b9cd344c9073a39

  create_table "activities", :force => true do |t|
    t.integer  "chapter_id"
    t.string   "title"
    t.text     "description"
    t.integer  "goal_id"
    t.integer  "from_template_activity_id"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "element_order",             :default => 0, :null => false
  end

  create_table "chapters", :force => true do |t|
    t.integer  "strategy_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "element_order"
    t.string   "type"
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "description"
    t.text     "about_the_author"
  end

  create_table "goals", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  create_table "hals", :force => true do |t|
    t.integer  "halable_id"
    t.string   "halable_type"
    t.text     "entry"
    t.boolean  "help"
    t.text     "insights"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "strategies", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "course_id"
    t.integer  "user_id"
    t.boolean  "is_template"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_chapter_id"
    t.string   "type"
  end

  create_table "timings", :force => true do |t|
    t.integer  "activity_id"
    t.string   "kind_of_timing"
    t.string   "info"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
<<<<<<< HEAD
    t.integer  "following_course_id"
=======
>>>>>>> dcc05d65dd23d3e8b8d3ce2b4b9cd344c9073a39
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
