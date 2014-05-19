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
end
