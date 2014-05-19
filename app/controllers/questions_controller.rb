class QuestionsController < ApplicationController
    before_action :authenticate_user!

  # # GET/questions/lance
  # def lance
  #   session[:revision] = true
  #   if session[:debut]
  #     @erreur = Erreur.where("created_at < ?", Time.at(session[:debut])).first
  #   else
  #     @erreur = Erreur.first
  #   end
  #   if @erreur
  #     session[:erreur]=true
  #     session[:id]=@erreur.ref
  #     session[:type]=@erreur.code
  #     session[:forme]=@erreur.forme
  #     @erreur.destroy
  #     redirect_to action: session[:type]
  #   else
  #     session[:erreur]=false
  #     if (rand*4).ceil > 3
  #      redirect_to action: 'conjugaison'
  #     else
  #       redirect_to action: 'vocabulaire'
  #     end
  #   end
  # end
  #
  # # GET/questions/conjugaison
  # def conjugaison
  #   session[:type] = 'conjugaison'
  #   if session[:id]
  #     @resultat = Conjugaison.question(session[:id], session[:forme])
  #     session[:id]=nil
  #   else
  #     @resultat = Conjugaison.tirage(Conjugaison.aleatoire(session[:conj_compteur_min],\
  #       session[:conj_date_min]),session[:conj_compteur_min],session[:conj_date_min])
  #     unless @resultat
  #       redirect_to parametres_edit_path
  #       return
  #     end
  #   end
  #   unless session.has_key?(:debut)
  #     session[:debut] = Time.now.to_i
  #     session[:bonnes_reponses], session[:mauvaises_reponses] = 0,0
  #   end
  #   params[:id] = @resultat[:conjugaison].id
  #   params[:infinitif] = @resultat[:conjugaison].infinitif
  #   params[:attendu] = @resultat[:attendu]
  #   params[:forme] = @resultat[:forme]
  #   params[:question] = Verbe.en_clair(@resultat[:forme])+@resultat[:conjugaison].infinitif+' ?'
  # end

  #GET/questions/vocabulaire
  def vocabulaire
    if current_user.admin
      redirect_to mots_path, notice: 'Vous ne pouvez pas réviser le vocabulaire'
      return
    end
    session[:type] = 'vocabulaire'
    unless session.has_key?(:debut)
      session[:debut] = Time.now.to_i
      session[:bonnes_reponses],session[:mauvaises_reponses] = 0,0
    end
#    if session[:id]
#      @resultat = Vocabulaire.question(session[:id])
#      session[:id]=nil
#    else
    @mot = current_user.tirage_mot
    unless @mot
      redirect_to parametres_edit_path, 'Les paramètres sont trop restrictifs'
      return
    end
#    end
    params[:id] = @mot.id
    params[:question] = @mot.francais
    params[:attendu] = @mot.italien
  end

  # POST/questions/verification
  def verification

    if params[:reponse]
      @objet = Mot.find(params[:id])
      @score = @objet.scores_mots.where(user_id: current_user.id).first
      params[:message] = Erreur.accepte?(params[:reponse],params[:attendu], @objet,current_user.id)
      if params[:message]
        session[:bonnes_reponses] += 1
      else
        session[:mauvaises_reponses] += 1
      end
      @score.score(params[:message]).save
      render action: session[:type]
    else
      if session[:revision] then
        redirect_to action: 'lance'
      else
        session[:type] = 'vocabulaire' unless session[:type]
        redirect_to action: session[:type]
      end
    end
  end
end

