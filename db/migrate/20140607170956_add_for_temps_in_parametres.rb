class AddForTempsInParametres < ActiveRecord::Migration
  def change
    add_column :parametres, :for_temps, :string
  end
end
