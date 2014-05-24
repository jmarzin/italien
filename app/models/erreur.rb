class Erreur < ActiveRecord::Base

  belongs_to :user
  belongs_to :mot
  belongs_to :verbe
  belongs_to :forme

  validates :code, inclusion: {in: ['mot','forme'], message: 'Le type doit être mot ou forme'}
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
      if objet.class == Mot
        Erreur.create!(code: 'mot',user_id: user_id, attendu: attendu, reponse: reponse, mot_id: objet.id)
      else
        Erreur.create!(code: 'forme', user_id: user_id, attendu: attendu, reponse: reponse, forme_id: objet.id)
      end
    end
    resultat
  end

end