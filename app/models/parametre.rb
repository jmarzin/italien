class ParametreValidator < ActiveModel::Validator
  def validate(record)

    @voc_compteur_min = record.voc_compteur_min
    @voc_revision_1_min = record.voc_revision_1_min
    @voc_category = record.voc_category
    @voc_delai_revision = record.voc_delai_revision
    if (eval 'User.find(record.user_id).scores_mots'+record.voc_req).count < 1
      record.errors[:base] << 'Les critères sur les mots sont trop contraignants'
    end
    @for_compteur_min = record.for_compteur_min
    @for_revision_1_min = record.for_revision_1_min
    @for_delai_revision = record.for_delai_revision
    if (eval 'User.find(record.user_id).scores_formes'+record.for_req).count < 1
      record.errors[:base] << 'Les critères sur les formes verbales sont trop contraignants'
    end
  end
end

class Parametre < ActiveRecord::Base
  belongs_to :user

  validates :voc_revision_1_min, presence: {message: 'La date minimum de 1ère révision est obligatoire'}
  validates :voc_compteur_min, numericality: { greater_than: -1, message: 'Le compteur minimum doit être un entier' }
  validates :for_revision_1_min, presence: {message: 'La date minimum de 1ère révision est obligatoire'}
  validates :for_compteur_min, numericality: { greater_than: -1, message: 'Le compteur minimum doit être un entier'}
  validates_with ParametreValidator

  alias update_original update

  def update_req(params)
    self.voc_req,self.for_req = '',''
    self.voc_req_will_change!
    self.for_req_will_change!
    unless params['voc_compteur_min'].blank?
      self.voc_req << ".where(\"compteur >= ?\",@voc_compteur_min)"
    end
    unless params['voc_revision_1_min'].blank?
      self.voc_req << ".where(\"date_rev_1 is null or date_rev_1 >= ?\",@voc_revision_1_min)"
    end
    unless params['voc_category'].blank?
      self.voc_req << ".where(category_id: @voc_category)"
    end
    unless params['voc_delai_revision'].blank?
      self.voc_req << ".where(\"date_rev_n is not null and date_rev_n < (current_timestamp - ? * interval '1 day')\",@voc_delai_revision)"
    end
    unless params['for_compteur_min'].blank?
      self.for_req << ".where(\"compteur >= ?\",@for_compteur_min)"
    end
    unless params['for_revision_1_min'].blank?
      self.for_req << ".where(\"date_rev_1 is null or date_rev_1 >= ?\",@for_revision_1_min)"
    end
    unless params['for_temps'].blank?
      self.for_req << ".where(rang_forme: #{params['for_temps']})"
    end
    unless params['for_delai_revision'].blank?
      self.for_req << ".where(\"date_rev_n is not null and date_rev_n < (current_timestamp - ? * interval '1 day')\",@for_delai_revision)"
    end
    self
  end

  def update(params)
    self.update_req(params)
    self.update_original(params)
  end
end
