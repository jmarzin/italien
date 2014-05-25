class RemoveColumnsFromErreurs < ActiveRecord::Migration
  def change
    remove_column :erreurs, :code, :string
    remove_column :erreurs, :mot_id, :integer
    remove_column :erreurs, :forme_id, :integer
  end
end
