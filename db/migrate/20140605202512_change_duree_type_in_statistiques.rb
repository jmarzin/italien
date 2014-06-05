class ChangeDureeTypeInStatistiques < ActiveRecord::Migration
  def change
    remove_column :statistiques, :duree
    add_column :statistiques, :duree, :integer
  end
end
