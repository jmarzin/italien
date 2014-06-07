class RenameCategorieToCategoryInMots < ActiveRecord::Migration
  def change
    rename_column :mots, :categorie_id, :category_id
  end
end
