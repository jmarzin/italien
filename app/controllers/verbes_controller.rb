class VerbesController < ApplicationController

  before_action :prepare_user
  before_action :set_autorisations
  before_action :set_verbe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  # GET /verbes
  # GET /verbes.json
  def index
    session[:page_v] = (params[:page] ||= session[:page_v])

    if @peut_supprimer
      @verbes = Verbe.joins(formes: :scores_formes).where("user_id = ?",current_user.id).\
        select("verbes.id, infinitif, verbes.created_at, verbes.updated_at, sum(compteur) as total_compteur").\
        group("verbes.id","infinitif","verbes.created_at","verbes.updated_at").\
        order(:infinitif).page params[:page]
    elsif @peut_corriger
      @verbes = Verbe.joins(formes: :scores_formes).merge(current_user.liste_scores_formes_a_reviser).\
        select("verbes.id, infinitif, verbes.created_at, verbes.updated_at, sum(compteur) as total_compteur").\
        group("verbes.id","infinitif","verbes.created_at","verbes.updated_at").\
        order(:infinitif).page params[:page]
    else
      @verbes = Verbe.joins(formes: :scores_formes).where("user_id = ? and (date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
      @user_eq_id,current_user.parametre.for_revision_1_min,current_user.parametre.for_compteur_min).\
        select("verbes.id, infinitif, verbes.created_at, verbes.updated_at, sum(compteur) as total_compteur").\
        group("verbes.id","infinitif","verbes.created_at","verbes.updated_at").\
        order(:infinitif).page params[:page]
    end

  end

  # GET /verbes/1
  # GET /verbes/1.json
  def show
  end

  # GET /verbes/new
  def new
    if @peut_supprimer
      @verbe = Verbe.new.init(current_user.id)
    else
      redirect_to verbes_path, notice: 'Vous ne pouvez pas créer un nouveau verbe'
    end
  end

  # GET /verbes/1/edit
  def edit
  end

  # POST /verbes
  # POST /verbes.json
  def create
    @verbe = Verbe.new(verbe_params).reduit(current_user.id)

    respond_to do |format|
      if @verbe.save
        User.all.each do |u|
          unless u.id == current_user.id
            @verbe.formes.each do |forme|
              unless forme.italien == ''
                forme.scores_formes.each do |score_forme_admin|
                  u.scores_formes.create(forme_id: score_forme_admin.forme_id,\
                    compteur: score_forme_admin.compteur, rang_forme: forme.rang_forme)
                end
              end
            end
          end
        end
        format.html { redirect_to @verbe, notice: 'Le verbe a bien été créé.' }
        format.json { render action: 'show', status: :created, location: @verbe }
      else
        format.html { render action: 'new' }
        format.json { render json: @verbe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /verbes/1
  # PATCH/PUT /verbes/1.json
  def update
    respond_to do |format|
      if @verbe.mise_a_jour(verbe_params,current_user.id)
        format.html { redirect_to @verbe, notice: 'Le verbe a été mis à jour.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @verbe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /verbes/1
  # DELETE /verbes/1.json
  def destroy
    if @peut_supprimer
      @verbe.destroy
      respond_to do |format|
        format.html { redirect_to verbes_url, notice: 'Le verbe a été supprimé.' }
        format.json { head :no_content }
      end
    else
      redirect_to verbes_path, notice: "Vous ne pouvez pas supprimer un verbe"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_verbe
      @verbe = Verbe.find(params[:id])
    end

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
      if @peut_corriger and not @peut_supprimer
        @user_eq_id = current_user.id
      else
        @user_eq_id = User.where(admin: true).first.id
      end
    end

  def prepare_user
    if user_signed_in?
      unless current_user.admin
        current_user.init_mots if current_user.mots.empty?
        current_user.init_formes if current_user.formes.empty?
        current_user.init_parametres unless current_user.parametre
      end
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def verbe_params
      params.require(:verbe).permit(:infinitif, formes_attributes: [:rang_forme, :italien, scores_formes_attributes: [:user_id, :compteur]])
    end
end
