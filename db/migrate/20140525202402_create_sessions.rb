class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.datetime :debut
      t.datetime :fin
      t.integer :bonnes_reponses
      t.integer :mauvaises_reponses

      t.timestamps
    end
    add_reference :sessions, :user
    add_index     :sessions, :user_id
  end
end
