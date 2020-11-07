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

ActiveRecord::Schema.define(version: 2020_11_07_113619) do

  create_table "bookings", force: :cascade do |t|
    t.integer "space_id", null: false
    t.integer "vehicle_id", null: false
    t.integer "cost_type_id", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cost_type_id"], name: "index_bookings_on_cost_type_id"
    t.index ["space_id", "date"], name: "index_bookings_on_space_id_and_date", unique: true
    t.index ["space_id"], name: "index_bookings_on_space_id"
    t.index ["vehicle_id", "date"], name: "index_bookings_on_vehicle_id_and_date", unique: true
    t.index ["vehicle_id"], name: "index_bookings_on_vehicle_id"
  end

  create_table "cost_types", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", precision: 5, scale: 2, null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cost_types_on_name", unique: true
  end

  create_table "spaces", force: :cascade do |t|
    t.integer "floor", null: false
    t.integer "row", null: false
    t.integer "column", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["floor", "row", "column"], name: "index_spaces_on_floor_and_row_and_column", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "registration_number", null: false
    t.string "make", null: false
    t.string "model", null: false
    t.string "colour", default: "unspecified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["registration_number"], name: "index_vehicles_on_registration_number", unique: true
  end

end
