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

ActiveRecord::Schema.define(version: 20151214181927) do

  create_table "benches", force: :cascade do |t|
    t.string   "description"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "seating",     default: 1, null: false
  end

  add_index "benches", ["lat"], name: "index_benches_on_lat"
  add_index "benches", ["lng"], name: "index_benches_on_lng"

end
