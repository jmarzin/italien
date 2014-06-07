class AddReferenceToCategoriesInMots < ActiveRecord::Migration
  def change
    add_reference :mots, :categorie
  end
end
