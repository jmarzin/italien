class AddIndexOnScoresFormes < ActiveRecord::Migration
  def change
    add_index :scores_formes, :id
    add_index :scores_formes, :forme_id
    add_index :scores_formes, :user_id
  end
end
