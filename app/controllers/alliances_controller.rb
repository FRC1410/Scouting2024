class AlliancesController < ApplicationController
  before_action :set_alliance, only: %i[ show edit update destroy ]

  # GET /alliances or /alliances.json
  def index
    @alliances = Alliance.all
  end

  # GET /alliances/1 or /alliances/1.json
  def show
  end

  # GET /alliances/new
  def new
    @alliance = Alliance.new
  end

  # GET /alliances/1/edit
  def edit
  end

  # POST /alliances or /alliances.json
  def create
    @alliance = Alliance.new(alliance_params)

    respond_to do |format|
      if @alliance.save
        format.html { redirect_to alliance_url(@alliance), notice: "Alliance was successfully created." }
        format.json { render :show, status: :created, location: @alliance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @alliance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alliances/1 or /alliances/1.json
  def update
    respond_to do |format|
      if @alliance.update(alliance_params)
        format.html { redirect_to alliance_url(@alliance), notice: "Alliance was successfully updated." }
        format.json { render :show, status: :ok, location: @alliance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @alliance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alliances/1 or /alliances/1.json
  def destroy
    @alliance.destroy!

    respond_to do |format|
      format.html { redirect_to alliances_url, notice: "Alliance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alliance
      @alliance = Alliance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def alliance_params
      params.require(:alliance).permit(:name, :competition_id)
    end
end
