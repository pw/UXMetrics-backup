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

ActiveRecord::Schema.define(version: 2020_12_19_013319) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_sort_cards", force: :cascade do |t|
    t.string "title", default: ""
    t.text "description", default: ""
    t.bigint "card_sort_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.boolean "has_description", default: false
    t.index ["card_sort_id"], name: "index_card_sort_cards_on_card_sort_id"
  end

  create_table "card_sort_groups", force: :cascade do |t|
    t.string "name", default: ""
    t.bigint "card_sort_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.boolean "merged", default: false
    t.string "type"
    t.bigint "merged_group_id"
    t.index ["card_sort_id"], name: "index_card_sort_groups_on_card_sort_id"
  end

  create_table "card_sort_participants", force: :cascade do |t|
    t.bigint "card_sort_id"
    t.integer "time"
    t.boolean "excluded", default: false
    t.integer "participant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "recording"
    t.index ["card_sort_id"], name: "index_card_sort_participants_on_card_sort_id"
  end

  create_table "card_sort_sorts", force: :cascade do |t|
    t.bigint "card_sort_id"
    t.bigint "card_sort_participant_id"
    t.bigint "card_sort_group_id"
    t.bigint "card_sort_card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pre_merge_group_id"
    t.index ["card_sort_card_id"], name: "index_card_sort_sorts_on_card_sort_card_id"
    t.index ["card_sort_group_id"], name: "index_card_sort_sorts_on_card_sort_group_id"
    t.index ["card_sort_id"], name: "index_card_sort_sorts_on_card_sort_id"
    t.index ["card_sort_participant_id"], name: "index_card_sort_sorts_on_card_sort_participant_id"
  end

  create_table "card_sorts", force: :cascade do |t|
    t.string "name", default: ""
    t.string "logo_key", default: ""
    t.text "participant_instructions", default: "Thank you for agreeing to help us! This shouldn't take more than 5 minutes.\n\nThere are no right or wrong answers. Our goal is to learn how you think about, organize and label certain topics into groups."
    t.text "thank_you_message", default: "Thanks for taking the time to help us!\n\nYour feedback is essential for us to deliver ongoing improvements."
    t.string "sort_type", default: "open"
    t.boolean "randomize_card_order", default: false
    t.string "auth_token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "draft"
    t.string "report_token"
    t.integer "creation_step", default: 1
    t.boolean "creation_wizard_complete", default: false
    t.boolean "report_private", default: false
    t.string "report_password", default: ""
    t.boolean "password_protect_report", default: false
    t.index ["user_id"], name: "index_card_sorts_on_user_id"
  end

  create_table "email_verifications", force: :cascade do |t|
    t.bigint "user_id"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token"], name: "index_email_verifications_on_token", unique: true
    t.index ["user_id"], name: "index_email_verifications_on_user_id"
  end

  create_table "password_resets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token"], name: "index_password_resets_on_token", unique: true
    t.index ["user_id"], name: "index_password_resets_on_user_id"
  end

  create_table "tree_test_participant_results", force: :cascade do |t|
    t.bigint "tree_test_participant_id"
    t.bigint "tree_test_task_id"
    t.integer "time"
    t.integer "choice"
    t.boolean "skip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "path"
    t.boolean "direct"
    t.string "outcome"
    t.boolean "excluded", default: false
    t.index ["tree_test_participant_id"], name: "index_tree_test_participant_results_on_tree_test_participant_id"
    t.index ["tree_test_task_id"], name: "index_tree_test_participant_results_on_tree_test_task_id"
  end

  create_table "tree_test_participants", force: :cascade do |t|
    t.bigint "tree_test_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "participant_id"
    t.boolean "excluded", default: false
    t.index ["tree_test_id"], name: "index_tree_test_participants_on_tree_test_id"
  end

  create_table "tree_test_task_correct_choices", force: :cascade do |t|
    t.integer "node"
    t.string "path"
    t.bigint "tree_test_task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tree_test_task_id"], name: "index_tree_test_task_correct_choices_on_tree_test_task_id"
  end

  create_table "tree_test_tasks", force: :cascade do |t|
    t.bigint "tree_test_id"
    t.text "instructions", default: "Task instructions (e.g. \"Imagine that you want to update your credit card details. Where would you find that?\")"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "task_number"
    t.integer "correct_choice"
    t.string "correct_path"
    t.index ["tree_test_id"], name: "index_tree_test_tasks_on_tree_test_id"
  end

  create_table "tree_tests", force: :cascade do |t|
    t.string "name", default: ""
    t.text "participant_instructions", default: "Thank you for agreeing to help us! This shouldn't take more than 5 minutes.\n\nThere are no right or wrong answers. Just do what makes sense to you."
    t.text "thank_you_message", default: "Thanks for taking the time to help us!\n\nYour feedback is essential for us to deliver ongoing improvements."
    t.boolean "randomize_tree_order", default: false
    t.jsonb "tree"
    t.boolean "randomize_task_order", default: false
    t.boolean "allow_skip", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "draft"
    t.bigint "user_id"
    t.integer "current_tree_index"
    t.string "auth_token"
    t.string "logo_key", default: ""
    t.string "report_token"
    t.boolean "report_private", default: false
    t.boolean "password_protect_report", default: false
    t.string "report_password", default: ""
    t.index ["auth_token"], name: "index_tree_tests_on_auth_token"
    t.index ["user_id"], name: "index_tree_tests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "verified", default: false
    t.boolean "subscribed", default: false
    t.string "stripe_customer_id"
    t.boolean "welcome_email_sent", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "card_sort_cards", "card_sorts"
  add_foreign_key "card_sort_groups", "card_sorts"
  add_foreign_key "card_sort_participants", "card_sorts"
  add_foreign_key "card_sort_sorts", "card_sort_cards"
  add_foreign_key "card_sort_sorts", "card_sort_groups"
  add_foreign_key "card_sort_sorts", "card_sort_participants"
  add_foreign_key "card_sort_sorts", "card_sorts"
  add_foreign_key "card_sorts", "users"
  add_foreign_key "password_resets", "users"
  add_foreign_key "tree_test_participant_results", "tree_test_participants"
  add_foreign_key "tree_test_participant_results", "tree_test_tasks"
  add_foreign_key "tree_test_participants", "tree_tests"
  add_foreign_key "tree_test_task_correct_choices", "tree_test_tasks"
  add_foreign_key "tree_tests", "users"
end
