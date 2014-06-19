class AddReferenceToCategoryInTraductions < ActiveRecord::Migration
  def change
    add_reference :traductions, :category
  end
end
