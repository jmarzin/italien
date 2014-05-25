class AddPolymorphicToErreurs < ActiveRecord::Migration
  def change
    change_table :erreurs do |t|
      t.references :en_erreur, polymorphic: true, index: true
    end
  end
  def down
    change_table :erreurs do |t|
      t.remove :en_erreur
    end
  end
end
