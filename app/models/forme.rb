class Forme < ActiveRecord::Base

  belongs_to :verbe

  has_many :scores_formes, dependent: :destroy
  accepts_nested_attributes_for :scores_formes
  has_many :erreurs, as: :en_erreur, dependent: :destroy
  has_many :users, through: :scores_formes

  TEMPS = [
      ['Gérondif',0..0],
      ['Participe passé',1..1]
  ]

  FORMES = [
      ['prétérit','','prétérit',8],
      ['participe passé','','participe passé',8],
  ]

  def question_en_francais
    Forme::FORMES[self.rang_forme][2]+' du verbe '+self.verbe.infinitif
  end

  def self.api_v1
    liste = []
    Forme.order(:verbe_id, :rang_forme).each do |forme|
      liste << [forme.verbe_id, forme.rang_forme + 1, forme.italien]
    end
    liste
  end
end
