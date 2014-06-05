namespace :stats do
  desc "Etablit des statistiques sur l'apprentissage"
  task :stats => :environment do
    User.all.each do |user|
      unless user.admin
        puts user.email
        user.sessions.select("date(debut) as date,\
          extract(minute from sum(fin-debut)) as duree, sum(bonnes_reponses) as bonnes,\
          sum(mauvaises_reponses) as mauvaises" ).group("date(debut)").\
          order("date").each do |ligne|
          print ligne.date,' ',ligne.duree,' ',ligne.bonnes+ligne.mauvaises,' ',\
            ligne.bonnes*100/(ligne.bonnes+ligne.mauvaises),"\n"
          unless user.statistiques.find_by(date: ligne.date)
            user.statistiques.create(date: ligne.date, duree: ligne.duree,\
              questions: ligne.bonnes+ligne.mauvaises,\
              taux: ligne.bonnes*100/(ligne.bonnes+ligne.mauvaises))
          end
        end
        champ_verbes = user.scores_formes.where("date_rev_1 is not null and compteur = 1").count
        champ_mots = user.scores_mots.where("date_rev_1 is not null and compteur = 1").count
        print champ_verbes,' ',champ_mots
        s=user.statistiques.last
        s.champ_verbes = champ_verbes
        s.champ_mots = champ_mots
        s.save!
      end
    end
  end
end
