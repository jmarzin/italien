class Mot < ActiveRecord::Base

  has_many :scores_mots, dependent: :destroy
  accepts_nested_attributes_for :scores_mots
  has_many :erreurs, as: :en_erreur, dependent: :destroy
  has_many :users, through: :scores_mots

  validates :mot_directeur, presence: {message: 'Le mot directeur est obligatoire'}
  validates :francais, presence: {message: 'Le mot ou expression en français est obligatoire'}
  validates :francais, uniqueness: {message: 'Le mot existe déjà' }
  validates :italien, presence: {message: 'La traduction italienne est obligatoire'}

  MAX_ESSAIS = 8
  SUCCES = 0.5
  ECHEC = 2

  def update(mot_params)
    self.mot_directeur = mot_params['mot_directeur']
    self.francais = mot_params['francais']
    self.italien = mot_params['italien']
    score = scores_mots.where(user_id: mot_params[:scores_mots_attributes]['0']['user_id']).first
    score.compteur = mot_params[:scores_mots_attributes]['0']['compteur']
    score.save
    self.save
  end

  def self.sauve(user_id)
    liste = File.new('db/mots/liste_mots.txt',mode='w')
    IO.write(liste,"liste = [\n")
    Mot.all.order(:mot_directeur).each do |v|
      IO.write(liste,\
        "[\""+v.mot_directeur.to_str+"\",\""+v.francais+"\","+\
        v.scores_mots.where(user_id: user_id).first.compteur.to_s+",\""+v.italien+"\"],\n",liste.size)
    end
    IO.write(liste,"]\n",liste.size-2)
    true
  end

end
