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

ActiveRecord::Schema.define(:version => 20131103022004) do

  create_table "activities", :force => true do |t|
    t.integer  "chapter_id"
    t.string   "title"
    t.text     "description"
    t.integer  "goal_id"
    t.integer  "from_template_activity_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "chapters", :force => true do |t|
    t.integer  "strategy_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "element_order", :default => 0, :null => false
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
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "goals", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "orderable_this", :force => true do |t|
    t.text     "description"
    t.integer  "element_order", :default => 0, :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "strategies", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "course_id"
    t.integer  "user_id"
    t.boolean  "is_template"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "current_chapter"
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
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
