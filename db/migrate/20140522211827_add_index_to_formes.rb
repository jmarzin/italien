class AddIndexToFormes < ActiveRecord::Migration
  def change
    add_index :formes, :id
  end
end
