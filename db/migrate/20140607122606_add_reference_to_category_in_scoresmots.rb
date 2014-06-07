class AddReferenceToCategoryInScoresmots < ActiveRecord::Migration
  def change
    add_reference :mots, :category
  end
end
