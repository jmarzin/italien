class ChangeDateForRevisionInParametres < ActiveRecord::Migration
  def change
    change_column :parametres, :for_revision_1_min, :date
  end
end
