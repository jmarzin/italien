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
    self.infinitif = vp['infinitif'] if vp['infinitif']
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
            sf.compteur = fa[1]['scores_formes_attributes'].first[1]['compteur'].to_i
          end
        else
          sf=fo.scores_formes.where(user_id: user_id).first
          sf.compteur = fa[1]['scores_formes_attributes'].first[1]['compteur'].to_i
          sf.save!
        end
      end
      fo.italien = fa[1]['italien'] if fa[1]['italien']
      fo.save!
    end
    self.save!
  end

  def self.sauve
    liste = File.new('db/verbes/liste_verbes.txt',mode='w')
    IO.write(liste,"liste = [\n",liste.size)
    Verbe.all.order(:infinitif).each do |v|
      texte = "[\""+v.infinitif+"\",\n["
      v.formes.each do |f|
        texte += "["+f.rang_forme.to_s + ", \"" + f.italien + "\"," + \
          f.scores_formes.find_by(user_id: User.find_by(admin: true).id).compteur.to_s+"],\n"
      end
      IO.write(liste,texte,liste.size)
      IO.write(liste,"],\n",liste.size-2)
    end
    IO.write(liste,"]]\n",liste.size-2)
    true
  end

end