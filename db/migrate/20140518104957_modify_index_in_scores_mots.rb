class ModifyIndexInScoresMots < ActiveRecord::Migration
  def change
    remove_index :scores_mots, [:user_id, :mot_id]
    add_index    :scores_mots, [:user_id, :mot_id], :unique => true
  end
end
