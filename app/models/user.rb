class Time
  def self.duree(heure_debut)
    duree = Time.at(Time.now - heure_debut)
    texte = ''
    if duree.hour > 1
      texte += "#{duree.hour - 1} h "
    end
    if duree.min > 0
      texte += "#{duree.min} min "
    end
    if duree.sec > 0
      texte += "#{duree.sec} sec"
    end
    texte
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :scores_mots
  has_many :mots, through: :scores_mots
  has_many :erreurs, dependent: :destroy
  has_one  :parametre
  has_many :scores_formes
  has_many :formes, through: :scores_formes
  has_many :sessions

  def init_tableau_mots
    parametre.tableau_ids_mots = []
    parametre.tableau_ids_mots_will_change!
    liste_scores_mots_a_reviser.each do |scores_mot|
      (1..scores_mot.compteur).each do |i|
        parametre.tableau_ids_mots<<scores_mot.mot.id
      end
    end
    parametre.save
  end

  def init_tableau_formes
    parametre.tableau_ids_formes = []
    parametre.tableau_ids_formes_will_change!
    liste_scores_formes_a_reviser.each do |scores_forme|
      (1..scores_forme.compteur).each do |i|
        parametre.tableau_ids_formes<<scores_forme.forme.id
      end
    end
    parametre.save
  end

  def err_sess_prec(date,class_objet)
    une_erreur = self.erreurs.where("en_erreur_type = ? and created_at < ?",class_objet,Time.at(date)).first
    if not une_erreur
      return false
    end
    @objet = class_objet.find(une_erreur.en_erreur_id)
    une_erreur.destroy
    @objet
  end

  def stats(bonnes, mauvaises)
    texte = ''
    if bonnes+mauvaises > 0
      if bonnes + mauvaises > 1
        texte += "#{bonnes + mauvaises} questions, "
      else
        texte += "1 question, "
      end
      texte += "#{(bonnes*100/(bonnes + mauvaises)).ceil} % de réussite"
    end
    texte
  end

  def liste_scores_mots_a_reviser
    scores_mots.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
        parametre.voc_revision_1_min,parametre.voc_compteur_min)
  end

  def liste_scores_formes_a_reviser
    scores_formes.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
        parametre.for_revision_1_min,parametre.for_compteur_min)
  end

  def tirage_mot
    unless parametre and parametre.tableau_ids_mots.size > 0
      return false
    end
    Mot.find(parametre.tableau_ids_mots[rand(parametre.tableau_ids_mots.size)])

#    rang = (rand * scores_mots.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
#        parametre.voc_revision_1_min,parametre.voc_compteur_min).sum(:compteur)).ceil
#    unless rang > 0
#      return false
#    end
#    mots.merge(ScoresMot.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
#        parametre.voc_revision_1_min,parametre.voc_compteur_min)).order(:mot_directeur).each do |m|
#      c = m.scores_mots.where(user_id: id).first.compteur
#      if c >= rang
#        return m
#      else
#        rang -= c
#      end
#    end
#    return false
  end

  def tirage_forme
    unless parametre and parametre.tableau_ids_formes.size > 0
      return false
    end
    Forme.find(parametre.tableau_ids_formes[rand(parametre.tableau_ids_formes.size)])

    # unless parametre
    #   return false
    # end
    # rang = (rand * scores_formes.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
    #     parametre.for_revision_1_min,parametre.for_compteur_min).sum(:compteur)).ceil
    # unless rang > 0
    #   return false
    # end
    # formes.merge(ScoresForme.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
    #     parametre.for_revision_1_min,parametre.for_compteur_min)).each do |f|
    #   c = f.scores_formes.where(user_id: id).first.compteur
    #   if c >= rang
    #     return f
    #   else
    #     rang -= c
    #   end
    # end
    # return false
  end

end
