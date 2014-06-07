class RenameCategorieToCategoryInScoresmots < ActiveRecord::Migration
  def change
    rename_column :scores_mots, :categorie_id, :category_id
  end
end
