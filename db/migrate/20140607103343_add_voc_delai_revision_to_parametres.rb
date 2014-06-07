class AddVocDelaiRevisionToParametres < ActiveRecord::Migration
  def change
    add_column :parametres, :voc_delai_revision, :integer
  end
end
