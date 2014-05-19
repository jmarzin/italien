class RenameTypeInCode < ActiveRecord::Migration
  def change
    rename_column :erreurs, :type, :code
  end
end
