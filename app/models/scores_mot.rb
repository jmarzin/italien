class ScoresMot < ActiveRecord::Base
  belongs_to :mot
  belongs_to :user
  validates :compteur, numericality: { greater_than: 0, message: 'Le compteur doit être un entier positif' }

  def score(ok)
    if ok
      facteur = Mot::SUCCES
    else
      facteur = Mot::ECHEC
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
