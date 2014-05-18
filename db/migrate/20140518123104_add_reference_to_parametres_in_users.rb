class AddReferenceToParametresInUsers < ActiveRecord::Migration
  def change
    add_reference :users, :parametre
  end
end
