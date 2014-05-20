class CreateFormes < ActiveRecord::Migration
  def change
    create_table :formes do |t|
      t.integer :rang_forme
      t.string :italien

      t.timestamps
    end
    add_reference :formes, :verbe
  end
end
