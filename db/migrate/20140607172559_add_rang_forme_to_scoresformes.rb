class AddRangFormeToScoresformes < ActiveRecord::Migration
  def change
    add_column :scores_formes, :rang_forme, :integer
  end
end
