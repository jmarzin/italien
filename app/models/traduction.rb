class String
  VIDE = [/^a /,/^in /,/^il /,/^lo /,/^l'/,/^la /,/^i /,/^le /,/^gli /,/^un /,/^una /,/^un'/]
  def reduit
    VIDE.each do |article|
      mat = article.match(self)
      if mat
        return mat.post_match
      end
    end
    return self
  end
end

class Traduction < ActiveRecord::Base

  def self.init
    Traduction.destroy_all
    Mot.all.each do |mot|
      mot.italien.split('/').each do |element|
        Traduction.create(italien: element.reduit.strip, francais: mot.francais, category_id: mot.category.numero)
      end
    end
  end
end
