ActiveRecord::Schema.define(version: 20150212004856) do

  create_table "answers", force: true do |t|
    t.string   "content"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["word_id"], name: "index_answers_on_word_id"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "learns", force: true do |t|
    t.integer  "user_id"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "learns", ["user_id"], name: "index_learns_on_user_id"
  add_index "learns", ["word_id"], name: "index_learns_on_word_id"

  create_table "lessons", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lessons", ["category_id"], name: "index_lessons_on_category_id"
  add_index "lessons", ["user_id"], name: "index_lessons_on_user_id"

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "results", force: true do |t|
    t.integer  "lesson_id"
    t.integer  "word_id"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "results", ["answer_id"], name: "index_results_on_answer_id"
  add_index "results", ["lesson_id"], name: "index_results_on_lesson_id"
  add_index "results", ["word_id"], name: "index_results_on_word_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "words", force: true do |t|
    t.string   "content"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "words", ["category_id"], name: "index_words_on_category_id"

end
