class AddNiveauToMots < ActiveRecord::Migration
  def change
    add_column :mots, :niveau, :integer
  end
end
