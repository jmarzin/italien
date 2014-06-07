class Verbe < ActiveRecord::Base

  has_many :formes, -> { order "rang_forme" }, dependent: :destroy
  accepts_nested_attributes_for :formes
  has_many :scores_formes, through: :formes, dependent: :destroy
  accepts_nested_attributes_for :scores_formes
  has_many :erreurs, through: :formes, dependent: :destroy

  validates :infinitif, presence: {message: "L'infinitif est obligatoire"}
  validates :infinitif, uniqueness: {message: 'Le verbe existe déjà' }

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

  def ajuste_compteur(fo,user_id,compteur)
    @scores_forme = fo.scores_formes.find_by(user_id: user_id)
    @scores_forme.compteur = compteur
    @scores_forme.rang_forme = fo.rang_forme
    @scores_forme.save!
  end

  def mise_a_jour(vp,user_id)
    @admin = User.find_by(id: user_id).admin
    self.infinitif = vp['infinitif'] if vp['infinitif']
    vp['formes_attributes'].each do |fa|
      fo = self.formes.find_by(rang_forme: fa[1]['rang_forme'].to_i)
      if fa[1]['italien'] == ''
        unless fo.italien == ''
          fo.scores_formes.destroy(fo.scores_formes.where("user_id <> ?",user_id))
        end
        ajuste_compteur(fo,user_id,0)
      else
        if fo.italien == '' and @admin
          User.all.each do |u|
            unless u.id == user_id
              fo.scores_formes.create(user_id: u.id)
            end
            ajuste_compteur(fo,u.id,fa[1]['scores_formes_attributes'].first[1]['compteur'].to_i)
          end
        elsif fa[1]['scores_formes_attributes']
          ajuste_compteur(fo,user_id,fa[1]['scores_formes_attributes'].first[1]['compteur'].to_i)
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
      IO.write(liste,"]],\n",liste.size-2)
    end
    IO.write(liste,"]\n",liste.size-2)
    true
  end

end