class Verbe < ActiveRecord::Base
  validates :infinitif, presence: {message: "L'infinitif est obligatoire"}
  validates :infinitif, uniqueness: {message: 'Le verbe existe déjà' }

  has_many :formes, -> { order "rang_forme" }, dependent: :destroy
  accepts_nested_attributes_for :formes
  has_many :scores_formes, through: :formes, dependent: :destroy
  accepts_nested_attributes_for :scores_formes
  has_many :erreurs, through: :formes, dependent: :destroy

  def init(current_user_id)
    Forme::FORMES.each_index do |rang|
    self.formes.build(rang_forme: rang).scores_formes.\
      build(user_id: current_user_id,compteur: Forme::FORMES[rang][3])
    end
    self
  end

  def reduit(user_id)
    self.formes.each do |f|
      if f.italien == ''
        f.scores_formes.each do |sf|
          if sf.user_id == user_id
            sf.compteur = 0
          end
        end
      end
    end
    self
  end

  def mise_a_jour(vp,user_id)
    self.infinitif = vp['infinitif']
    vp['formes_attributes'].each do |fa|
      fo = self.formes.where(rang_forme: fa[1]['rang_forme'].to_i).first
      if fa[1]['italien'] == ''
        if fo.italien == ''
          fo.scores_formes.where(user_id: user_id).first.compteur = 0
        else
          fo.scores_formes.each do |sf|
            sf.compteur = 0
          end
        end
      else
        if fo.italien == ''
          fo.scores_formes.each do |sf|
            sf.compteur = fa[1]['scores_formes_attributes']['0']['compteur'].to_i
          end
        else
          sf=fo.scores_formes.where(user_id: user_id).first
          sf.compteur = fa[1]['scores_formes_attributes']['0']['compteur'].to_i
          sf.save!
        end
      end
      fo.italien = fa[1]['italien']
      fo.save!
    end
    self.save!
  end

  def self.sauve

  end

end