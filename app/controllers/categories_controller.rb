class CategoriesController < ApplicationController
  before_action :prepare_user
  before_action :set_autorisations
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]


  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.order(:numero)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    if @peut_supprimer
      @category = Category.new
    else
      redirect_to categories_path, notice: "Vous ne pouvez pas créer une nouvelle catégorie"
    end
  end

  # GET /categories/1/edit
  def edit
    unless @peut_supprimer
      redirect_to categories_path, notice: "Vous ne pouvez pas modifier une catégorie"
    end
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'La catégorie a été créée.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'La catégorie a été mise à jour.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    if @peut_supprimer
      if @category.destroy
        respond_to do |format|
          format.html { redirect_to categories_url, notice: 'La catégorie a été supprimée.'  }
          format.json { head :no_content }
        end
      else
        redirect_to categories_path, notice: "Impossible de supprimer cette catégorie"
      end
    else
      redirect_to categories_path, notice: "Vous ne pouvez pas supprimer une catégorie"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    def set_autorisations
      @peut_supprimer = false
      if user_signed_in?
        if current_user.admin
          @peut_supprimer = true
        end
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
    def category_params
      params.require(:category).permit(:numero, :description)
    end

end
