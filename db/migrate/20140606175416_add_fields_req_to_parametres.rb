class AddFieldsReqToParametres < ActiveRecord::Migration
  def change
    add_column :parametres, :voc_req, :string
    add_column :parametres, :for_req, :string
  end
end
