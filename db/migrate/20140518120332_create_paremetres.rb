class CreateParemetres < ActiveRecord::Migration
  def change
    create_table :parametres do |t|
      t.integer  :voc_compteur_min
      t.date     :voc_revision_1_min

      t.timestamps
    end
    add_reference :parametres, :user
  end
end
