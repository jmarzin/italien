class ScoresMot < ActiveRecord::Base
  belongs_to :mot
  belongs_to :user
  validates :compteur, numericality: { greater_than: 0, message: 'Le compteur doit être un entier positif' }

  def score(ok)
    ancien = self.compteur
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
    ecart = self.compteur - ancien
    unless ecart == 0
      @param = Parametre.find_by(user_id: self.user_id)
      @param.tableau_ids_will_change!
      if ecart > 0
        (1..ecart).each do |i|
          @param.tableau_ids<<self.mot_id
        end
      else
        if self.compteur < @param.voc_compteur_min
          while (rang = @param.tableau_ids.find_index(self.mot_id)) do
            @param.tableau_ids.delete_at(rang)
          end
        else
          (1..(-ecart)).each do |i|
            rang = @param.tableau_ids.find_index(self.mot_id)
            @param.tableau_ids.delete_at(rang)
          end
        end
      end
      @param.save!
    end
    self
  end

end
