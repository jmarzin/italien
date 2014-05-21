class VerbesController < ApplicationController

  before_action :prepare_user
  before_action :set_autorisations
  before_action :set_verbe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  # GET /verbes
  # GET /verbes.json
  def index
    session[:page_v] = (params[:page_v] ||= session[:page_v])
    if @peut_corriger and not @peut_supprimer
      @verbes = current_user.formes.merge(ScoresVerbe.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
        current_user.parametre.for_revision_1_min,current_user.parametre.for_compteur_min)).order(:infinitif).page params[:page_v]
    else
      @verbes = Verbe.order(:infinitif).page params[:page_v]
    end
  end

  # GET /verbes/1
  # GET /verbes/1.json
  def show
  end

  # GET /verbes/new
  def new
    if @peut_supprimer
      @verbe = Verbe.new
      Forme::FORMES.each_index do |rang|
        @verbe.formes << Forme.new(rang_forme: rang)
      end
      @verbe.formes.each do |forme|
        forme.scores_formes << ScoresForme.new(user_id: current_user.id,compteur: Forme::MAX_ESSAIS)
      end
    else
      redirect_to verbes_path, notice: "Vous ne pouvez pas créer un nouveau verbe"
    end
  end

  # GET /verbes/1/edit
  def edit
  end

  # POST /verbes
  # POST /verbes.json
  def create
    @verbe = Verbe.new(verbe_params)

    respond_to do |format|
      if @verbe.save
        format.html { redirect_to @verbe, notice: 'Verbe was successfully created.' }
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
      if @verbe.update(verbe_params)
        format.html { redirect_to @verbe, notice: 'Verbe was successfully updated.' }
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
    @verbe.destroy
    respond_to do |format|
      format.html { redirect_to verbes_url }
      format.json { head :no_content }
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
    def verbe_params
      params.require(:verbe).permit(:infinitif, formes_attributes: [:rang_forme, :italien, scores_formes_attributes: [:user_id, :compteur]])
    end
end
