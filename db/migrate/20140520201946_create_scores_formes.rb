class CreateScoresFormes < ActiveRecord::Migration
  def change
    create_table :scores_formes do |t|
      t.integer :compteur
      t.datetime :date_rev_1
      t.datetime :date_rev_n

      t.timestamps
    end
    add_reference :scores_formes, :verbe
    add_reference :scores_formes, :forme
    add_reference :scores_formes, :user
  end
end
