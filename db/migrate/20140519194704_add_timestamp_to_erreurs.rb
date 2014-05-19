class AddTimestampToErreurs < ActiveRecord::Migration
  def change
    add_column :erreurs, :created_at, :datetime
    add_column :erreurs, :updated_at, :datetime
  end
end
