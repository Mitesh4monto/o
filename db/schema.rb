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

ActiveRecord::Schema.define(:version => 20140106220202) do

  create_table "activities", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "element_order",        :default => 0,    :null => false
    t.integer  "user_id"
    t.integer  "from_id"
    t.boolean  "active",               :default => true
    t.string   "activityable_type"
    t.integer  "activityable_id"
    t.integer  "next_activity"
    t.integer  "activity_sequence_id"
    t.integer  "sequence_order"
    t.integer  "position"
    t.string   "kind_of_timing"
    t.string   "timing_expression"
    t.string   "timing_duration"
    t.integer  "strategy_id"
    t.integer  "course_id"
    t.string   "customization"
    t.integer  "goal_id"
  end

  create_table "activity_sequences", :force => true do |t|
    t.integer  "goal_id"
    t.integer  "current_activity_id"
    t.integer  "strategy_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "element_order",       :default => 0, :null => false
    t.integer  "user_id"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
  end

  create_table "commitment_marks", :force => true do |t|
    t.integer  "user_id"
    t.date     "done_date"
    t.integer  "cmable_id"
    t.string   "cmable_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
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
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.text     "description"
    t.text     "about_the_author"
    t.text     "overview"
    t.boolean  "published",        :default => false
  end

  create_table "goals", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "user_id"
    t.integer  "from_id"
    t.boolean  "active",      :default => true
  end

  create_table "hals", :force => true do |t|
    t.integer  "halable_id"
    t.string   "halable_type"
    t.text     "entry"
    t.boolean  "help"
    t.text     "insights"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "fromable_id"
    t.string   "fromable_type"
    t.integer  "course_id"
    t.integer  "privacy"
  end

  create_table "mercury_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "strategies", :force => true do |t|
    t.text     "description"
    t.integer  "course_id"
    t.integer  "user_id"
    t.boolean  "is_template", :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "type"
    t.integer  "from_id"
    t.boolean  "active",      :default => true
  end

  create_table "user_followings", :id => false, :force => true do |t|
    t.integer "user_a_id", :null => false
    t.integer "user_b_id", :null => false
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
    t.integer  "following_course_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
