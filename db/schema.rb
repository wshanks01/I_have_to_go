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

ActiveRecord::Schema.define(version: 20160615221558) do

  create_table "bathrooms", force: :cascade do |t|
    t.text  "store_name"
    t.float "longitude"
    t.float "latitude"
    t.text  "address"
    t.text  "wheelchair_access"
    t.text  "family_friendly"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "rating"
    t.integer "bathrooms_id"
    t.integer "users_id"
  end

  create_table "users", force: :cascade do |t|
    t.text  "username"
    t.text  "pwd"
    t.text  "email"
    t.float "longitude"
    t.float "latitude"
    t.text  "address"
  end

end
