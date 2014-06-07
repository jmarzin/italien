class ScoresMot < ActiveRecord::Base
  belongs_to :mot
  belongs_to :category
  belongs_to :user
  validates :compteur, numericality: { greater_than: 0, message: 'Le compteur doit être un entier positif' }

  MAX_ESSAIS = 8
  SUCCES = 0.5
  ECHEC = 2

  include Score

end
