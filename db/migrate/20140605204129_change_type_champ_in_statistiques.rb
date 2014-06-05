class ChangeTypeChampInStatistiques < ActiveRecord::Migration
  def change
    remove_column :statistiques, :champ_verbes
    add_column :statistiques, :champ_verbes, :integer
    remove_column :statistiques, :champ_mots
    add_column :statistiques, :champ_mots, :integer
  end
end
