class ScoresForme < ActiveRecord::Base
  belongs_to :user
  belongs_to :forme, -> { includes :verbe }

  def score(ok)
    ancien = self.compteur
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
    ecart = self.compteur - ancien
    unless ecart == 0
      @param = Parametre.find_by(user_id: self.user_id)
      @param.tableau_ids_formes_will_change!
      if ecart > 0
        (1..ecart).each do |i|
          @param.tableau_ids_formes<<self.forme_id
        end
      else
        if self.compteur < @param.for_compteur_min
          while (rang = @param.tableau_ids_formes.find_index(self.forme_id)) do
            @param.tableau_ids_formes.delete_at(rang)
          end
        else
          (1..(-ecart)).each do |i|
            rang = @param.tableau_ids_formes.find_index(self.forme_id)
            @param.tableau_ids_formes.delete_at(rang)
          end
        end
      end
      @param.save!
    end
    self
  end

end
