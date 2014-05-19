class ChangeDateToDatetimeInScoresMots < ActiveRecord::Migration
  def change
    change_column :scores_mots, :date_rev_1, :datetime
    change_column :scores_mots, :date_rev_n, :datetime
  end
end
