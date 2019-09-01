# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_04_024259) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assemblies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "assembly_items", force: :cascade do |t|
    t.bigint "assembly_id"
    t.bigint "item_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "qty", default: 1
    t.index ["assembly_id"], name: "index_assembly_items_on_assembly_id"
    t.index ["item_id"], name: "index_assembly_items_on_item_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "department_id"
    t.index ["department_id"], name: "index_items_on_department_id"
  end

  create_table "location_departments", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.bigint "department_id", null: false
    t.integer "sort_order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_location_departments_on_department_id"
    t.index ["location_id"], name: "index_location_departments_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "meal_schedules", force: :cascade do |t|
    t.datetime "schedule_date", null: false
    t.boolean "purchased", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "item_id"
    t.bigint "order_item_id"
    t.bigint "assembly_id"
    t.string "meal_time"
    t.index ["assembly_id"], name: "index_meal_schedules_on_assembly_id"
    t.index ["item_id"], name: "index_meal_schedules_on_item_id"
    t.index ["order_item_id"], name: "index_meal_schedules_on_order_item_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "item_id"
    t.bigint "assembly_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "department_id"
    t.boolean "picked", default: false
    t.integer "qty", default: 1
    t.index ["assembly_id"], name: "index_order_items_on_assembly_id"
    t.index ["department_id"], name: "index_order_items_on_department_id"
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "location_id"
    t.datetime "shopping_date"
    t.index ["location_id"], name: "index_orders_on_location_id"
  end

  add_foreign_key "assembly_items", "assemblies"
  add_foreign_key "assembly_items", "items"
  add_foreign_key "items", "departments"
  add_foreign_key "location_departments", "departments"
  add_foreign_key "location_departments", "locations"
  add_foreign_key "meal_schedules", "assemblies"
  add_foreign_key "meal_schedules", "items"
  add_foreign_key "meal_schedules", "order_items"
  add_foreign_key "order_items", "assemblies"
  add_foreign_key "order_items", "departments"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "locations"
end
