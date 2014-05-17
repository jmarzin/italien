class CreateVerbes < ActiveRecord::Migration
  def change
    create_table :verbes do |t|
      t.string :infinitif
      t.timestamps
    end
  end
end
