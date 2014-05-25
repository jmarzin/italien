class QuestionsController < ApplicationController
    before_action :authenticate_user!

  # GET/questions/lance
  def lance
    session[:revision] = true
    if rand(4) > 2
      redirect_to action: 'conjugaison'
    else
      redirect_to action: 'vocabulaire'
    end
  end

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
      @session = current_user.sessions.create(debut: Time.at(session[:debut]),\
        fin: Time.now,bonnes_reponses: 0, mauvaises_reponses: 0)
      session[:session_id]= @session.id
    end


    if session[:erreurs_mots_traitees]
      @mot = current_user.tirage_mot
    else
      @mot = current_user.err_sess_prec(session[:debut],Mot)
      unless @mot
        @mot = current_user.tirage_mot
        session[:erreurs_mots_traitees] = true
      end
    end
    unless @mot
      redirect_to parametres_edit_path, 'Les paramètres sont trop restrictifs'
      return
    end
    params[:id] = @mot.id
    params[:question] = @mot.francais
    params[:attendu] = @mot.italien
  end

    #GET/questions/conjugaison
    def conjugaison
      if current_user.admin
        redirect_to verbes_path, notice: 'Vous ne pouvez pas réviser les conjugaisons'
        return
      end
      session[:type] = 'conjugaison'
      unless session.has_key?(:debut)
        session[:debut] = Time.now.to_i
        session[:bonnes_reponses],session[:mauvaises_reponses] = 0,0
        @session = current_user.sessions.create(debut: Time.at(session[:debut]),\
        fin: Time.now,bonnes_reponses: 0, mauvaises_reponses: 0)
        session[:session_id]= @session.id
      end
      if session[:erreurs_formes_traitees]
        @forme = current_user.tirage_forme
      else
        @forme = current_user.err_sess_prec(session[:debut],Forme)
        unless @forme
          @forme = current_user.tirage_forme
          session[:erreurs_formes_traitees] = true
        end
      end
      unless @forme
        redirect_to parametres_edit_path, 'Les paramètres sont trop restrictifs'
        return
      end
      params[:id] = @forme.id
      params[:question] = Forme::FORMES[@forme.rang_forme][2]+' du verbe '+@forme.verbe.infinitif
      params[:attendu] = @forme.italien
    end

  # POST/questions/verification
  def verification

    if params[:reponse]
      if session[:type] == 'vocabulaire'
        @objet = Mot.find(params[:id])
        @score = @objet.scores_mots.find_by(user_id: current_user.id)
      else
        @objet = Forme.find(params[:id])
        @score = @objet.scores_formes.find_by(user_id: current_user.id)
      end
      params[:message] = Erreur.accepte?(params[:reponse],params[:attendu], @objet,current_user.id)
      if params[:message]
        session[:bonnes_reponses] += 1
      else
        session[:mauvaises_reponses] += 1
      end
      @score.score(params[:message]).save
      @session = Session.find(session[:session_id])
      @session.fin = Time.now
      @session.bonnes_reponses = session[:bonnes_reponses]
      @session.mauvaises_reponses = session[:mauvaises_reponses]
      @session.save!
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
