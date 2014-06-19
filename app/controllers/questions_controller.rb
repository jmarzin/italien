class QuestionsController < ApplicationController
    before_action :authenticate_user!

  # GET/questions/lance
  def revision
    session[:revision] = true
    if rand(4) > 2
      redirect_to action: 'conjugaison'
    else
      redirect_to action: 'vocabulaire'
    end
  end

  def revision_vocabulaire
    session[:revision] = false
    redirect_to action: 'vocabulaire'
  end

  def revision_conjugaison
    session[:revision] = false
    redirect_to action: 'conjugaison'
  end

  #GET/questions/vocabulaire
  def vocabulaire
    init_session(mots_path, 'le vocabulaire')
    construit_question(Mot)
  end

    #GET/questions/conjugaison
  def conjugaison
    init_session(verbes_path,'les conjugaisons')
    construit_question(Forme)
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
      @session = Session.find(session[:ma_session_id].to_i)
      @session.fin = Time.now
      @session.bonnes_reponses = session[:bonnes_reponses]
      @session.mauvaises_reponses = session[:mauvaises_reponses]
      @session.save!
      render action: session[:type]
    else
      if session[:revision] then
        redirect_to action: 'revision'
      else
        session[:type] = 'vocabulaire' unless session[:type]
        redirect_to action: session[:type]
      end
    end
  end

  private

  def init_session(path,text)
    if current_user.admin
      redirect_to path, notice: 'Vous ne pouvez pas réviser '+text
      return
    end
    session[:type] = text.split[1].singularize
    unless session.has_key?(:debut)
      session[:debut] = Time.now.to_i
      session[:bonnes_reponses],session[:mauvaises_reponses] = 0,0
      @session = current_user.sessions.create(debut: Time.at(session[:debut]),\
        fin: Time.now,bonnes_reponses: 0, mauvaises_reponses: 0)
      session[:ma_session_id]= @session.id
      session[:tableau_mots_ok] = false
      session[:tableau_formes_ok] = false
    end
    unless session[:tableau_mots_ok]
      current_user.init_tableau_mots if path == mots_path
      session[:tableau_mots_ok] = true
    end
    unless session[:tableau_formes_ok]
      current_user.init_tableau_formes if path == verbes_path
      session[:tableau_formes_ok] = true
    end

  end

  def construit_question(classe)
    erreurs_traitees = 'erreurs_'+classe.name.downcase.pluralize+'_traitees'
    if session[erreurs_traitees]
      @objet = current_user.tirage(classe,\
          current_user.parametre.send('tableau_ids_'+classe.name.downcase.pluralize))
    else
      @objet = current_user.err_sess_prec(session[:debut],classe)
      unless @objet
        @objet = current_user.tirage(classe,\
          current_user.parametre.send('tableau_ids_'+classe.name.downcase.pluralize))\
          if current_user.parametre
        session[erreurs_traitees] = true
      end
    end
    unless @objet
      redirect_to edit_parametre_path(current_user.parametre), notice: 'Les paramètres sont trop restrictifs'
      return
    end
    params[:id] = @objet.id
    params[:question] = @objet.question_en_francais
    params[:attendu] = @objet.italien
  end

end
