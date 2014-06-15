class ProblemesController < ApplicationController
  before_action :set_probleme, only: [:show, :edit, :update, :destroy]

  # GET /problemes
  # GET /problemes.json
  def index
    @problemes = Probleme.all
  end

  # GET /problemes/1
  # GET /problemes/1.json
  def show
  end

  # GET /problemes/new
  def new
    @probleme = Probleme.new
  end

  # GET /problemes/1/edit
  def edit
  end

  # POST /problemes
  # POST /problemes.json
  def create
    @probleme = Probleme.new(probleme_params)

    respond_to do |format|
      if @probleme.save
        format.html { redirect_to @probleme, notice: 'Probleme was successfully created.' }
        format.json { render action: 'show', status: :created, location: @probleme }
      else
        format.html { render action: 'new' }
        format.json { render json: @probleme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problemes/1
  # PATCH/PUT /problemes/1.json
  def update
    respond_to do |format|
      if @probleme.update(probleme_params)
        format.html { redirect_to @probleme, notice: 'Probleme was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @probleme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problemes/1
  # DELETE /problemes/1.json
  def destroy
    @probleme.destroy
    respond_to do |format|
      format.html { redirect_to problemes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_probleme
      @probleme = Probleme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def probleme_params
      params.require(:probleme).permit(:texte, :corrige, :date_correction)
    end
end
