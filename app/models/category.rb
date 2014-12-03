class Category < ActiveRecord::Base
  has_many :mots, dependent: :restrict_with_error
  has_many :scores_mots, dependent: :restrict_with_error

  def self.sauve
    liste = File.new('db/mots/liste_categories.txt',mode='w')
    IO.write(liste,"liste = [\n")
    Category.all.order(:numero).each do |c|
      IO.write(liste,\
        "["+c.numero.to_s+",\""+c.description+"\"],\n",liste.size)
    end
    IO.write(liste,"]\n",liste.size-2)
    true
  end

  def numero_description
    self.numero.to_s+' '+self.description
  end

  def self.api_v1
    liste = []
    Category.order(:numero).each do |cat|
      if cat.numero <= 22
        liste << [cat.numero, cat.description]
      end
    end
    liste
  end

end
