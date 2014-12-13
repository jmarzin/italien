class Mot < ActiveRecord::Base

  has_many :scores_mots, dependent: :destroy
  accepts_nested_attributes_for :scores_mots
  has_many :erreurs, as: :en_erreur, dependent: :destroy
  has_many :users, through: :scores_mots
  belongs_to :category

  validates :mot_directeur, presence: {message: 'Le mot directeur est obligatoire'}
  validates :francais, presence: {message: 'Le mot ou expression en français est obligatoire'}
  validates :francais, uniqueness: { scope: :category_id, message: 'Le mot existe déjà' }
  validates :italien, presence: {message: 'La traduction italienne est obligatoire'}

  def self.recherche(recherche)
    if recherche
      Mot.where('mot_directeur || francais || italien like ?','%'+recherche+'%')
    else
      Mot.all
    end
  end

  def update(mot_params)
    self.mot_directeur = mot_params['mot_directeur']
    self.francais = mot_params['francais']
    self.italien = mot_params['italien']
    self.niveau = mot_params['niveau']
    unless mot_params['category_id'] == self.category_id
      self.category_id = mot_params['category_id']
      User.all.each do |u|
        sc = u.scores_mots.find_by(mot_id: self.id)
        sc.category_id = self.category_id
        sc.save!
      end
    end
    score = scores_mots.where(user_id: mot_params[:scores_mots_attributes]['0']['user_id']).first
    score.compteur = mot_params[:scores_mots_attributes]['0']['compteur']
    score.save
    self.save
  end

  def question_en_francais
    self.francais + ' (' + self.category.description + ')'
  end

  def self.sauve(user_id)
    liste = File.new('db/mots/liste_mots.txt',mode='w')
    IO.write(liste,"liste = [\n")
    Mot.all.order(:mot_directeur).each do |v|
      IO.write(liste,\
        "["+v.category_id.to_s+",\""+v.mot_directeur.to_str+"\",\""+v.francais+"\","+\
        v.scores_mots.where(user_id: user_id).first.compteur.to_s+",\""+v.italien+"\"],\n",liste.size)
    end
    IO.write(liste,"]\n",liste.size-2)
    true
  end

  def self.api_v1
    liste = []
    Mot.order(:category_id, :mot_directeur, :francais).each do |mot|
      liste << [mot.category.numero, mot.francais, mot.mot_directeur, mot.italien]
    end
    liste
  end

  def self.api_v2
    liste = []
    Mot.order(:category_id, :mot_directeur, :francais).each do |mot|
      liste << [mot.id, mot.category.numero, mot.francais, mot.mot_directeur, mot.italien]
    end
    liste
  end

end
