class AddReferenceToFormeEtVerbeInErreur < ActiveRecord::Migration
  def change
    add_reference :erreurs, :forme
  end
end
