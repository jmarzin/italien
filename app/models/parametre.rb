class ParametreValidator < ActiveModel::Validator
  def validate(record)
    if (User.find(record.user_id).scores_mots.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
      record.voc_revision_1_min,record.voc_compteur_min).count < 1) or\
      (User.find(record.user_id).scores_formes.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
      record.for_revision_1_min,record.for_compteur_min).count < 1)
        record.errors[:base] << 'Les critères sont trop contraignants'
    end
  end
end

class Parametre < ActiveRecord::Base
  belongs_to :user

  validates :voc_revision_1_min, presence: {message: 'La date minimum de 1ère révision est obligatoire'}
  validates :voc_compteur_min, numericality: { greater_than: -1, message: 'Le compteur minimum doit être un entier' }
  validates_with ParametreValidator

end
