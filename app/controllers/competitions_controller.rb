class CompetitionsController < ApplicationController
  before_action :set_competition, only: %i[ show scores edit update destroy upload_matches upload_teams]

  # GET /competitions or /competitions.json
  def index
    @competitions = Competition.all
  end

  def scores
    @matches = @competition.matches.eager_load(
      red_alliance: [team_score_sheets: [:team, :user]],
      blue_alliance: [team_score_sheets: [:team, :user]]
    ).order(:match_number)
  end

  # GET /competitions/1 or /competitions/1.json
  def show
  end

  # GET /competitions/new
  def new
    @competition = Competition.new
  end

  # GET /competitions/1/edit
  def edit
  end

  # POST /competitions or /competitions.json
  def create
    @competition = Competition.new(competition_params)

    respond_to do |format|
      if @competition.save
        format.html { redirect_to competition_url(@competition), notice: "Competition was successfully created." }
        format.json { render :show, status: :created, location: @competition }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /competitions/1 or /competitions/1.json
  def update
    respond_to do |format|
      if @competition.update(competition_params)
        format.html { redirect_to competition_url(@competition), notice: "Competition was successfully updated." }
        format.json { render :show, status: :ok, location: @competition }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competitions/1 or /competitions/1.json
  def destroy
    @competition.destroy!

    respond_to do |format|
      format.html { redirect_to competitions_url, notice: "Competition was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def upload_matches
    if !@competition.create_matches_from_file(params[:match][:match_file])
      redirect_to competitions_url, alert: "Match number already exists"
    end
  end

  def upload_teams
    result = @competition.create_teams_from_file(params[:competition][:teams_file])
    if !result[:success]
      redirect_to competitions_url, alert: "Error adding teams to competition. Teams missing: : #{result[:missing_teams].join(", ")}"
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_competition
      @competition = Competition.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def competition_params
      params.require(:competition).permit(:name, :date)
    end
end
