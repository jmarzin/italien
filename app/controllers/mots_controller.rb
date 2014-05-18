class MotsController < ApplicationController

  before_action :prepare_user
  before_action :set_autorisations
  before_action :set_mot, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]


  # GET /mots
  # GET /mots.json
  def index
    session[:page] = (params[:page] ||= session[:page])
    if @peut_corriger and not @peut_supprimer
      @mots = current_user.mots.merge(ScoresMot.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
        current_user.parametre.voc_revision_1_min,current_user.parametre.voc_compteur_min)).order(:mot_directeur).page params[:page]
    else
      @mots = Mot.order(:mot_directeur).page params[:page]
    end
  end

  # GET /mots/1
  # GET /mots/1.json
  def show
  end

  # GET /mots/new
  def new
    if @peut_supprimer
      @mot = Mot.new
      @mot.scores_mots.build(user_id: current_user.id,compteur: Mot::MAX_ESSAIS)
    else
      redirect_to mots_path, notice: "Vous ne pouvez pas créer un nouveau mot"
    end
  end

  # GET /mots/1/edit
  def edit
  end

  # POST /mots
  # POST /mots.json
  def create
    @mot = Mot.new(mot_params)

    respond_to do |format|
      if @mot.save
        compteur = @mot.scores_mots[0].compteur
        User.all.each do |u|
          unless u.id == current_user.id
            u.scores_mots.build(user_id: u.id,mot_id: @mot.id,compteur: compteur)
            u.save
          end
        end
        format.html { redirect_to @mot, notice: 'Le mot a été créé' }
        format.json { render action: 'show', status: :created, location: @mot }
      else
        format.html { render action: 'new' }
        format.json { render json: @mot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mots/1
  # PATCH/PUT /mots/1.json
  def update
    respond_to do |format|
      if @mot.update(mot_params)
        format.html { redirect_to @mot, notice: 'Mot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mots/1
  # DELETE /mots/1.json
  def destroy
    if @peut_supprimer
      @mot.destroy
      respond_to do |format|
        format.html { redirect_to mots_url }
        format.json { head :no_content }
      end
    else
      redirect_to mots_path, notice: "Vous ne pouvez pas supprimer un mot"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_autorisations
      @peut_corriger = false
      @peut_supprimer = false
      if user_signed_in?
        if current_user.admin
          @peut_corriger = true
          @peut_supprimer = true
        else
          @peut_corriger = true
        end
      end
    end
    def set_mot
      @mot = Mot.find(params[:id])
    end
    def prepare_user
      if user_signed_in?
        unless current_user.admin
          if current_user.mots.empty?
            User.where(admin: true).first.scores_mots.each do |sco|
              current_user.scores_mots.build(mot_id: sco.mot_id, compteur: sco.compteur)
            end
            current_user.save
          end
          if current_user.parametre == nil
            current_user.create_parametre(voc_compteur_min: 0, \
              voc_revision_1_min: current_user.scores_mots.minimum('date_rev_1') || Time.now)
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mot_params
      params.require(:mot).permit(:mot_directeur, :francais, :italien, \
        scores_mots_attributes: [:compteur,:user_id])
    end
end
