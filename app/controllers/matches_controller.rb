class MatchesController < ApplicationController
  before_action :set_competition, only: %i[ index create destroy ]
  before_action :set_match, only: %i[ show unlock edit update destroy ]

  # GET /matches or /matches.json
  def index
    @matches = @competition.matches.eager_load(
      red_alliance: [team_score_sheets: [:team,:user]],
      blue_alliance: [team_score_sheets: [:team, :user]]
    ).order(:match_number)
    @match = Match.new(competition: @competition)
  end

  def show
  end

  def edit
  end

  def unlock
    @match.red_alliance.team_score_sheets.update(currently_locked: false)
    @match.blue_alliance.team_score_sheets.update(currently_locked: false)
    redirect_to competition_matches_path(@match.competition)
  end

  # POST /matches or /matches.json
  def create
    red_alliance = Alliance.new(color: :red, teams: Team.find(params[:match][:red_alliance_teams].reject(&:blank?)))
    blue_alliance = Alliance.new(color: :blue, teams: Team.find(params[:match][:blue_alliance_teams].reject(&:blank?)))
    @match = Match.new(
      competition: @competition,
      match_number: params[:match][:match_number],
      red_alliance: red_alliance,
      blue_alliance: blue_alliance
    )

    respond_to do |format|
      if @match.save
        format.html { redirect_to match_url(@match), notice: "Match was successfully created." }
        format.json { render :show, status: :created, location: @match }
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            "toggle_new",
            partial: "matches/form",
            locals: { match: Match.new(competition: @competition), competition: @competition }
          )
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @match.errors, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            "toggle_new",
            partial: "matches/form",
            locals: { match: @match, competition: @competition }
          )
        end
      end
    end
  end

  # PATCH/PUT /matches/1 or /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to match_url(@match), notice: "Match was successfully updated." }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1 or /matches/1.json
  def destroy
    @match.destroy!

    respond_to do |format|
      format.html { redirect_to competition_matches_path(@competition), notice: "Match was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_competition
    @competition = Competition.find(params[:competition_id])
  end

  def set_match
    @match = Match.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def match_params
    params.require(:match).permit(:number, :red_alliance_teams, :blue_alliance_teams)
  end
end
