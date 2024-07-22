# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_07_19_040721) do
  create_table "items", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.integer "category_id", null: false
    t.integer "condition_id", null: false
    t.integer "postage_payer_id", null: false
    t.integer "prefecture_id", null: false
    t.integer "preparation_day_id", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
