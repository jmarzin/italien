class Verbe < ActiveRecord::Base
  validates :infinitif, presence: {message: "L'infinitif est obligatoire"}
  validates :infinitif, uniqueness: {message: 'Le verbe existe déjà' }

  has_many :formes, dependent: :destroy
  accepts_nested_attributes_for :formes
  has_many :scores_formes, through: :formes, dependent: :destroy
  accepts_nested_attributes_for :scores_formes
  has_many :erreurs, through: :formes, dependent: :destroy

end
