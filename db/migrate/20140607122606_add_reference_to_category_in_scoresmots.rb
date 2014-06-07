class AddReferenceToCategoryInScoresmots < ActiveRecord::Migration
  def change
    add_reference :scores_mots, :category
  end
end
