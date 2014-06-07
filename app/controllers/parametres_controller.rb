class ParametresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parametre, only: [:edit, :update]

  # GET /parametres/edit
  def edit
    if current_user.admin
      redirect_to mots_path, notice: "Vous ne pouvez pas paramètrer la révision"
    else
      @parametre = current_user.parametre
      @voc_nb = current_user.liste_scores_mots_a_reviser.count
      @for_nb = current_user.liste_scores_formes_a_reviser.count
    end
  end

  def update
    respond_to do |format|
      if @parametre.update(parametre_params)
        session[:page_m] = 1
        session[:page_v] = 1
        session[:tableau_mots_ok] = false
        session[:tableau_formes_ok] = false
        format.html { redirect_to edit_parametre_path(@parametre), notice: 'Les paramètres ont été mis à jour' }
        format.json { head :no_content }
      else
        if @parametre.errors[:base].to_s.include?('mots')
          @voc_nb = 0
        else
          @voc_nb = current_user.liste_scores_mots_a_reviser.count
        end
        if @parametre.errors[:base].to_s.include?('formes')
          @for_nb = 0
        else
          @for_nb = current_user.liste_scores_formes_a_reviser.count
        end
        format.html { render action: 'edit' }
        format.json { render json: @mot.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_parametre
    @parametre = Parametre.find(params[:id])
  end

  def parametre_params
    params.require(:parametre).permit(:voc_compteur_min, :voc_revision_1_min, :voc_category, :voc_delai_revision,\
                                      :for_compteur_min, :for_revision_1_min, :for_delai_revision, :for_temps)
  end
end
