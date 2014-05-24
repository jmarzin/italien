class ScoresForme < ActiveRecord::Base
  belongs_to :user
  belongs_to :forme, -> { includes :verbe }

  def score(ok)
    if ok
      facteur = Forme::SUCCES
    else
      facteur = Forme::ECHEC
    end
    if (self.compteur * facteur).round >= 1
      self.compteur = (self.compteur * facteur).round
    else
      self.compteur = 1
    end
    self.date_rev_1 ||= Time.now
    self.date_rev_n = Time.now
    self
  end

end
