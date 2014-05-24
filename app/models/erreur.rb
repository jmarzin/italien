class Erreur < ActiveRecord::Base

  belongs_to :user
  belongs_to :mot
  belongs_to :verbe
  belongs_to :forme

  validates :code, inclusion: {in: ['mot'], message: 'Le type doit être vocabulaire'}
  validates :attendu, presence: {message: 'La réponse attendue est obligatoire'}

  def self.accepte?(reponse, attendu, objet, user_id)
    if reponse == ''
      resultat = false
    else
      reponses = reponse.downcase.strip.split('/')
      attendus = attendu.downcase.strip.split('/')
      resultat = true
      reponses.each do |rep|
        resultat = resultat && attendus.include?(rep)
      end
    end
    unless resultat
      Erreur.create!(code: 'mot',user_id: user_id, attendu: attendu, reponse: reponse, mot_id: objet.id)
    end
    resultat
  end

end