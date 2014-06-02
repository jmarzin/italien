class ScoresForme < ActiveRecord::Base
  belongs_to :user
  belongs_to :forme, -> { includes :verbe }

  SUCCES = 0.5
  ECHEC = 2

  include Score

end
