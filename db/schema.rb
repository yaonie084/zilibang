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

ActiveRecord::Schema.define(:version => 20110816170724) do

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "price"
    t.string   "code"
    t.boolean  "verified",         :default => false
    t.boolean  "buyer_sure",       :default => false
    t.boolean  "employer_sure",    :default => false
    t.text     "buyer_content"
    t.integer  "buyer_level",      :default => 0
    t.text     "employer_content"
    t.integer  "employer_level",   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "messages", :force => true do |t|
    t.integer  "sender_id",                      :null => false
    t.integer  "receiver_id",                    :null => false
    t.boolean  "visited",     :default => false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "longtime"
    t.string   "tel"
    t.string   "state"
    t.boolean  "over",        :default => false
    t.boolean  "finish",      :default => false
    t.integer  "low_price"
    t.integer  "high_price"
    t.integer  "user_id"
    t.boolean  "paid",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string  "title"
    t.string  "name"
    t.boolean "male"
    t.string  "school"
    t.integer "graduation"
    t.string  "tel"
    t.string  "plan"
    t.text    "description"
    t.string  "avatar_file_name"
    t.string  "avatar_content_type"
    t.integer "avatar_file_size"
    t.integer "user_id"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.integer  "score",         :default => 0
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "transactions", :force => true do |t|
    t.string   "notify_id"
    t.float    "total_fee"
    t.string   "trade_status"
    t.string   "trade_no"
    t.datetime "notify_time"
    t.text     "raw_post"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "buyer_email"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :null => false
    t.string   "crypted_password",                      :null => false
    t.string   "password_salt",                         :null => false
    t.string   "persistence_token",                     :null => false
    t.string   "perishable_token",   :default => "",    :null => false
    t.integer  "gold",               :default => 0
    t.integer  "goodwill",           :default => 0
    t.string   "role"
    t.boolean  "superadmin",         :default => false
    t.integer  "login_count",        :default => 0,     :null => false
    t.integer  "failed_login_count", :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
