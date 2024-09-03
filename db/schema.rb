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

ActiveRecord::Schema[7.2].define(version: 2024_08_14_013048) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "payment_statuses", ["prompt", "early", "late", "overdue", "upcoming", "waived"]
  create_enum "property_kind", ["single_family", "condo", "co_op", "townhome", "multi_family"]
  create_enum "redistribution_strategies", ["management", "roommates"]
  create_enum "responses", ["no", "yes", "maybe", "awaiting"]
  create_enum "utility_kind", ["gas", "electric", "water", "internet", "trash"]

  create_table "chores", force: :cascade do |t|
    t.bigint "user_group_rental_id", null: false
    t.string "title"
    t.text "description"
    t.interval "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_group_rental_id"], name: "index_chores_on_user_group_rental_id"
  end

  create_table "event_invitations", force: :cascade do |t|
    t.bigint "invitee_id", null: false
    t.bigint "inviter_id", null: false
    t.bigint "property_event_id", null: false
    t.string "title"
    t.text "description"
    t.enum "invite_response", default: "maybe", null: false, enum_type: "responses"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invitee_id"], name: "index_event_invitations_on_invitee_id"
    t.index ["inviter_id"], name: "index_event_invitations_on_inviter_id"
    t.index ["property_event_id"], name: "index_event_invitations_on_property_event_id"
  end

  create_table "four_walls", force: :cascade do |t|
    t.bigint "real_property_id", null: false
    t.string "name", null: false
    t.index ["real_property_id"], name: "index_four_walls_on_real_property_id"
  end

  create_table "grievances", force: :cascade do |t|
    t.bigint "user_group_rental_id", null: false
    t.boolean "anonymous", default: true, null: false
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_group_rental_id"], name: "index_grievances_on_user_group_rental_id"
  end

  create_table "management_group_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "management_group_id", null: false
    t.boolean "admin", default: false
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin", "management_group_id"], name: "management_group_users_single_admin_idx", unique: true, where: "(admin IS TRUE)"
    t.index ["management_group_id"], name: "index_management_group_users_on_management_group_id"
    t.index ["user_id"], name: "index_management_group_users_on_user_id"
  end

  create_table "management_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_transactions", force: :cascade do |t|
    t.bigint "user_group_rental_id", null: false
    t.interval "occupancy_duration"
    t.enum "rent_payment_status", default: "upcoming", null: false, enum_type: "payment_statuses"
    t.datetime "rent_payment_due_date"
    t.datetime "rent_payment_received_date"
    t.integer "rent_amount"
    t.enum "utilities_payment_status", default: "upcoming", null: false, enum_type: "payment_statuses"
    t.datetime "utilities_payment_due_date"
    t.datetime "utilities_payment_received_date"
    t.integer "utilities_amount"
    t.boolean "utilities_included", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_group_rental_id"], name: "index_payment_transactions_on_user_group_rental_id"
  end

  create_table "property_events", force: :cascade do |t|
    t.string "type"
    t.boolean "mandatory", default: false, null: false
    t.bigint "user_group_rental_id", null: false
    t.boolean "property_wide"
    t.text "description"
    t.datetime "event_date"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_group_rental_id"], name: "index_property_events_on_user_group_rental_id"
  end

  create_table "property_resource_items", force: :cascade do |t|
    t.bigint "property_resource_id", null: false
    t.integer "starting_quantity"
    t.integer "current_quantity"
    t.integer "total_cost"
    t.integer "length"
    t.datetime "year"
    t.date "expiration_date"
    t.string "color"
    t.boolean "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_resource_id"], name: "index_property_resource_items_on_property_resource_id"
  end

  create_table "property_resources", force: :cascade do |t|
    t.string "name"
    t.boolean "open", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "real_properties", force: :cascade do |t|
    t.bigint "management_group_id", null: false
    t.string "address", null: false
    t.string "name"
    t.enum "kind", null: false, enum_type: "property_kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["management_group_id"], name: "index_real_properties_on_management_group_id"
  end

  create_table "rent_exemptions", force: :cascade do |t|
    t.bigint "user_group_rental_id", null: false
    t.bigint "user_id", null: false
    t.integer "exemption_percentage", default: 100, null: false
    t.datetime "exemption_expiration"
    t.enum "redistribution_strategy", default: "management", null: false, enum_type: "redistribution_strategies"
    t.text "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_group_rental_id"], name: "index_rent_exemptions_on_user_group_rental_id"
    t.index ["user_id"], name: "index_rent_exemptions_on_user_id"
  end

  create_table "rental_histories", force: :cascade do |t|
    t.integer "rent_rate", null: false
    t.bigint "user_group_rental_id", null: false
    t.string "parking_assignment"
    t.boolean "available"
    t.datetime "date_of_change"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_group_rental_id"], name: "index_rental_histories_on_user_group_rental_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.bigint "four_wall_id", null: false
    t.integer "rent_rate", default: 0, null: false
    t.boolean "available", default: false
    t.string "address", null: false
    t.string "parking_assignment"
    t.string "primary_door_access_code"
    t.string "secondary_door_access_code"
    t.string "name", null: false
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["four_wall_id"], name: "index_rentals_on_four_wall_id"
  end

  create_table "request_decisions", force: :cascade do |t|
    t.bigint "request_id", null: false
    t.boolean "granted"
    t.text "explanation"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_request_decisions_on_request_id"
    t.index ["user_id"], name: "index_request_decisions_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "user_group_rental_id", null: false
    t.string "title"
    t.text "description"
    t.string "type"
    t.datetime "appointment_date"
    t.interval "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_group_rental_id"], name: "index_requests_on_user_group_rental_id"
  end

  create_table "user_group_rentals", force: :cascade do |t|
    t.bigint "user_group_id", null: false
    t.bigint "rental_id", null: false
    t.daterange "occupancy_range"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rental_id"], name: "index_user_group_rentals_on_rental_id"
    t.index ["user_group_id"], name: "index_user_group_rentals_on_user_group_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.string "name"
    t.bigint "management_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["management_group_id"], name: "index_user_groups_on_management_group_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "display_name"
    t.string "name", null: false
    t.string "phone_number"
    t.string "email", null: false
    t.string "type"
    t.bigint "user_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_group_id"], name: "index_users_on_user_group_id"
  end

  create_table "utility_exemptions", force: :cascade do |t|
    t.bigint "utility_item_id", null: false
    t.bigint "user_group_rental_id", null: false
    t.bigint "user_id", null: false
    t.integer "exemption_percentage", default: 100, null: false
    t.datetime "exemption_expiration"
    t.text "reason"
    t.enum "redistribution_strategy", default: "management", null: false, enum_type: "redistribution_strategies"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_group_rental_id"], name: "index_utility_exemptions_on_user_group_rental_id"
    t.index ["user_id"], name: "index_utility_exemptions_on_user_id"
    t.index ["utility_item_id"], name: "index_utility_exemptions_on_utility_item_id"
  end

  create_table "utility_groups", force: :cascade do |t|
    t.bigint "four_wall_id", null: false
    t.datetime "date"
    t.boolean "property_wide"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["four_wall_id"], name: "index_utility_groups_on_four_wall_id"
  end

  create_table "utility_items", force: :cascade do |t|
    t.bigint "utility_group_id", null: false
    t.enum "kind", null: false, enum_type: "utility_kind"
    t.integer "total"
    t.boolean "deffered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind", "utility_group_id"], name: "index_utility_items_on_kind_and_utility_group_id", unique: true
    t.index ["utility_group_id"], name: "index_utility_items_on_utility_group_id"
  end

  create_table "utility_splits", force: :cascade do |t|
    t.bigint "utility_group_id", null: false
    t.bigint "user_group_rental_id", null: false
    t.integer "split_rate"
    t.interval "occupancy_duration"
    t.integer "split_points"
    t.integer "split_charge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_group_rental_id"], name: "index_utility_splits_on_user_group_rental_id"
    t.index ["utility_group_id"], name: "index_utility_splits_on_utility_group_id"
  end

  add_foreign_key "chores", "user_group_rentals"
  add_foreign_key "event_invitations", "property_events"
  add_foreign_key "event_invitations", "users", column: "invitee_id"
  add_foreign_key "event_invitations", "users", column: "inviter_id"
  add_foreign_key "four_walls", "real_properties"
  add_foreign_key "grievances", "user_group_rentals"
  add_foreign_key "management_group_users", "management_groups"
  add_foreign_key "management_group_users", "users"
  add_foreign_key "payment_transactions", "user_group_rentals"
  add_foreign_key "property_events", "user_group_rentals"
  add_foreign_key "property_resource_items", "property_resources"
  add_foreign_key "real_properties", "management_groups"
  add_foreign_key "rent_exemptions", "user_group_rentals"
  add_foreign_key "rent_exemptions", "users"
  add_foreign_key "rental_histories", "user_group_rentals"
  add_foreign_key "rentals", "four_walls"
  add_foreign_key "request_decisions", "requests"
  add_foreign_key "request_decisions", "users"
  add_foreign_key "requests", "user_group_rentals"
  add_foreign_key "user_group_rentals", "rentals"
  add_foreign_key "user_group_rentals", "user_groups"
  add_foreign_key "user_groups", "management_groups"
  add_foreign_key "users", "user_groups"
  add_foreign_key "utility_exemptions", "user_group_rentals"
  add_foreign_key "utility_exemptions", "users"
  add_foreign_key "utility_exemptions", "utility_items"
  add_foreign_key "utility_groups", "four_walls"
  add_foreign_key "utility_items", "utility_groups"
  add_foreign_key "utility_splits", "user_group_rentals"
  add_foreign_key "utility_splits", "utility_groups"
end
