class ParametresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parametre, only: [:edit, :update]

  # GET /parametres/edit
  def edit
    if current_user.admin
      redirect_to mots_path, notice: "Vous ne pouvez pas paramètrer la révision"
    else
      @voc_nb = current_user.scores_mots.where("(date_rev_1 is null or date_rev_1 >= ?) and compteur >= ?",\
        current_user.parametre.voc_revision_1_min,current_user.parametre.voc_compteur_min).count
      @parametre = current_user.parametre
    end
  end

  def update
    respond_to do |format|
      if @parametre.update(parametre_params)
        format.html { render action: 'edit', notice: 'Mot was successfully updated.' }
        format.json { head :no_content }
      else
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
    params.require(:parametre).permit(:voc_compteur_min, :voc_revision_1_min)
  end
end
