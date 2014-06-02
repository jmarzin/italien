module Score
  def mise_a_jour_tableau(ecart)
    @param = Parametre.find_by(user_id: self.user_id)
    if self.class == ScoresForme
      @param.tableau_ids_formes_will_change!
      @tableau = @param.tableau_ids_formes
      @id = self.forme_id
      @compteur_min = @param.for_compteur_min
    else
      @param.tableau_ids_mots_will_change!
      @tableau = @param.tableau_ids_mots
      @id = self.mot_id
      @compteur_min = @param.voc_compteur_min
    end
    if ecart > 0
      (1..ecart).each do |i|
        @tableau<<@id
      end
    else
      if self.compteur < @compteur_min
        while (rang = @tableau.find_index(@id)) do
          @tableau.delete_at(rang)
        end
      else
        (1..(-ecart)).each do |i|
          rang = @tableau.find_index(@id)
          @tableau.delete_at(rang)
        end
      end
    end
    @param.save
  end


  def score(ok)
    ancien = self.compteur
    if ok
      facteur = self.class::SUCCES
    else
      facteur = self.class::ECHEC
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
      self.mise_a_jour_tableau(ecart)
    end
    self
  end
end