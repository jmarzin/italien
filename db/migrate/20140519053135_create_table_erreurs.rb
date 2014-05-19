class CreateTableErreurs < ActiveRecord::Migration
  def change
    create_table :erreurs do |t|
      t.string  :type
      t.string  :attendu
      t.string  :reponse

      t.timestamp
    end
    add_reference :erreurs, :user
    add_reference :erreurs, :mot
  end
end
