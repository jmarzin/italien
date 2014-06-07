class AddCategoryToParametres < ActiveRecord::Migration
  def change
    add_column :parametres, :voc_category, :integer
  end
end
