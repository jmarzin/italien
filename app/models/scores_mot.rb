class ScoresMot < ActiveRecord::Base
  belongs_to :mot
  belongs_to :user
  validates :compteur, numericality: { greater_than: 0, message: 'Le compteur doit être un entier positif' }
end
