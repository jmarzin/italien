class CreateScoresMots < ActiveRecord::Migration
  def change
    create_table :scores_mots do |t|
      t.integer :compteur
      t.date    :date_rev_1
      t.date    :date_rev_n
    end
    add_reference :scores_mots, :user
    add_reference :scores_mots, :mot
    add_index     :scores_mots, [:user_id, :mot_id]
  end
end
