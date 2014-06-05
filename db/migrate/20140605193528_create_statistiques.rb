class CreateStatistiques < ActiveRecord::Migration
  def change
    create_table :statistiques do |t|
      t.date :date
      t.time :duree
      t.integer :questions
      t.float :taux
      t.string :champ_verbes
      t.string :champ_mots

      t.timestamps
    end
    add_reference :statistiques, :user
  end
end
