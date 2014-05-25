class Erreur < ActiveRecord::Base

  belongs_to :user
  belongs_to :en_erreur, polymorphic: true

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
      objet.erreurs.create!(user_id: user_id,attendu: attendu, reponse: reponse)
    end
    resultat
  end

end