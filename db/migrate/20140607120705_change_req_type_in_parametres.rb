class ChangeReqTypeInParametres < ActiveRecord::Migration
  def change
    change_column :parametres, :voc_req, :text
    change_column :parametres, :for_req, :text
  end
end
