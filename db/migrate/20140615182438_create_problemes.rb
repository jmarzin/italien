class CreateProblemes < ActiveRecord::Migration
  def change
    create_table :problemes do |t|
      t.text :texte
      t.boolean :corrige
      t.datetime :date_correction

      t.timestamps
    end
    add_reference :problemes, :user
  end
end
