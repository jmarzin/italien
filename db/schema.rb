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

ActiveRecord::Schema.define(version: 20140522211827) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "erreurs", force: true do |t|
    t.string   "code"
    t.string   "attendu"
    t.string   "reponse"
    t.integer  "user_id"
    t.integer  "mot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forme_id"
  end

  create_table "formes", force: true do |t|
    t.integer  "rang_forme"
    t.string   "italien"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "verbe_id"
  end

  add_index "formes", ["id"], name: "index_formes_on_id", using: :btree

  create_table "mots", force: true do |t|
    t.string   "mot_directeur"
    t.string   "francais"
    t.string   "italien"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parametres", force: true do |t|
    t.integer  "voc_compteur_min"
    t.date     "voc_revision_1_min"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "for_compteur_min"
    t.datetime "for_revision_1_min"
  end

  create_table "scores_formes", force: true do |t|
    t.integer  "compteur"
    t.datetime "date_rev_1"
    t.datetime "date_rev_n"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forme_id"
    t.integer  "user_id"
  end

  add_index "scores_formes", ["forme_id"], name: "index_scores_formes_on_forme_id", using: :btree
  add_index "scores_formes", ["id"], name: "index_scores_formes_on_id", using: :btree
  add_index "scores_formes", ["user_id"], name: "index_scores_formes_on_user_id", using: :btree

  create_table "scores_mots", force: true do |t|
    t.integer  "compteur"
    t.datetime "date_rev_1"
    t.datetime "date_rev_n"
    t.integer  "user_id"
    t.integer  "mot_id"
  end

  add_index "scores_mots", ["user_id", "mot_id"], name: "index_scores_mots_on_user_id_and_mot_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.integer  "parametre_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "verbes", force: true do |t|
    t.string   "infinitif"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
