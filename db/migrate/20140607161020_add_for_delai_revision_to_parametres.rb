class AddForDelaiRevisionToParametres < ActiveRecord::Migration
  def change
    add_column :parametres, :for_delai_revision, :integer
  end
end
