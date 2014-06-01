class AddArrayToParametres < ActiveRecord::Migration
  def change
    add_column :parametres, :tableau_ids, :integer, :array => true
  end
end
