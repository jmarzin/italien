class VerbesController < ApplicationController
  before_action :set_verbe, only: [:show, :edit, :update, :destroy]

  # GET /verbes
  # GET /verbes.json
  def index
    @verbes = Verbe.all
  end

  # GET /verbes/1
  # GET /verbes/1.json
  def show
  end

  # GET /verbes/new
  def new
    @verbe = Verbe.new
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def verbe_params
      params.require(:verbe).permit(:infinitif)
    end
end
