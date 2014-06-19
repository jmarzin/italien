class CreateTraductions < ActiveRecord::Migration
  def change
    create_table :traductions do |t|
      t.string :italien
      t.string :francais

      t.timestamps
    end
  end
end
