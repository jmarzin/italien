class ScoresForme < ActiveRecord::Base
  belongs_to :user
  belongs_to :forme, -> { includes :verbe }
end
