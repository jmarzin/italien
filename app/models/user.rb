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

  def err_mot_sess_prec(date)
    erreur = self.erreurs.where("mot_id is not null and created_at < ?",Time.at(date)).first
    if not erreur
      return false
    end
    @mot = Mot.find(erreur.mot_id)
    erreur.destroy
    @mot
  end

  def err_forme_sess_prec(date)
    erreur = self.erreurs.where("forme_id is not null and created_at < ?",Time.at(date)).first
    if not erreur
      return false
    end
    @forme = Forme.find(erreur.forme_id)
    erreur.destroy
    @forme
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

  def tirage_mot
    unless parametre
      return false
    end
    rang = (rand * scores_mots.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
        parametre.voc_revision_1_min,parametre.voc_compteur_min).count).ceil
    unless rang > 0
      return false
    end
    mots.merge(ScoresMot.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
        parametre.voc_revision_1_min,parametre.voc_compteur_min)).order(:mot_directeur).each do |m|
      c = m.scores_mots.where(user_id: id).first.compteur
      if c >= rang
        return m
      else
        rang -= c
      end
    end
    return false
  end

  def tirage_forme
    unless parametre
      return false
    end
    rang = (rand * scores_formes.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
        parametre.for_revision_1_min,parametre.for_compteur_min).count).ceil
    unless rang > 0
      return false
    end
    formes.merge(ScoresForme.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
        parametre.for_revision_1_min,parametre.for_compteur_min)).each do |f|
      c = f.scores_formes.where(user_id: id).first.compteur
      if c >= rang
        return f
      else
        rang -= c
      end
    end
    return false
  end

end
