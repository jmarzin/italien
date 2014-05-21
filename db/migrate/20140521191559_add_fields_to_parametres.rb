class AddFieldsToParametres < ActiveRecord::Migration
  def change
    add_column :parametres, :for_compteur_min, :integer
    add_column :parametres, :for_revision_1_min, :datetime
  end
end
