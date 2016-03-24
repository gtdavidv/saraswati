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

ActiveRecord::Schema.define(version: 20160318232858) do

  create_table "chats", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "text"
    t.integer  "chat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "bot_message", default: false
  end

  add_index "messages", ["chat_id"], name: "index_messages_on_chat_id"

  create_table "nodes", force: :cascade do |t|
    t.text     "nugget"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "node_a_id"
    t.integer  "node_b_id"
    t.string   "a_to_b_relationship"
    t.string   "b_to_a_relationship"
    t.decimal  "strength",            default: 0.0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
