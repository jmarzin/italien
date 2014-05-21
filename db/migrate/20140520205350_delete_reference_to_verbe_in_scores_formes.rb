class DeleteReferenceToVerbeInScoresFormes < ActiveRecord::Migration
  def change
    remove_reference :scores_formes, :verbe
  end
end
