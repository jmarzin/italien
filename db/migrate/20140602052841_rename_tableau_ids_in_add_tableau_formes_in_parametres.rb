class RenameTableauIdsInAddTableauFormesInParametres < ActiveRecord::Migration
  def change
    rename_column :parametres, :tableau_ids, :tableau_ids_mots
    add_column :parametres, :tableau_ids_formes, :integer, :array => true
  end
end
