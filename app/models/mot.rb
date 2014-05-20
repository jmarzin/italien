class Mot < ActiveRecord::Base

  validates :mot_directeur, presence: {message: 'Le mot directeur est obligatoire'}
  validates :francais, presence: {message: 'Le mot ou expression en français est obligatoire'}
  validates :francais, uniqueness: {message: 'Le mot existe déjà' }
  validates :italien, presence: {message: 'La traduction italienne est obligatoire'}

  def update(mot_params)
    mot_directeur = mot_params['mot_directeur']
    francais = mot_params['francais']
    italien = mot_params['italien']
    score = scores_mots.where(user_id: mot_params[:scores_mots_attributes]['0']['user_id']).first
    score.compteur = mot_params[:scores_mots_attributes]['0']['compteur']
    score.save
    self.save
  end

  has_many :scores_mots, dependent: :destroy
  accepts_nested_attributes_for :scores_mots
  has_many :erreurs, dependent: :destroy
  has_many :users, through: :scores_mots


  MAX_ESSAIS = 8
  SUCCES = 0.5
  ECHEC = 2

end
