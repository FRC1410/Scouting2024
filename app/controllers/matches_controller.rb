require "twilio-ruby"

class MatchesController < ApplicationController
  before_action :set_competition, only: %i[ notify index create destroy ]
  before_action :set_match, only: %i[ notify show unlock edit update destroy ]

  # GET /matches or /matches.json
  def index
    @matches = @competition.matches.eager_load(
      red_alliance: [team_score_sheets: [:team, :user]],
      blue_alliance: [team_score_sheets: [:team, :user]]
    ).order("matches.match_number, team_score_sheets.id")
    @match = Match.new(competition: @competition)
  end

  def notify
    success = true
    details = [
      account_sid = ENV["TWILIO_SSID"],
      auth_token = ENV["TWILIO_API"],
      twilio_phone = ENV["TWILIO_PHONE"],
    ]

    success = success && details.all?(&:present?)

    @client = Twilio::REST::Client.new account_sid, auth_token

    @match.team_score_sheets.each do |score_sheet|
      user = score_sheet.user
      if success && user.present? && user.user_phone.present?
        message = @client.messages.create(
          body: "Heads up! You are scouting team #{score_sheet.team.number} for match #{@match.match_number} soon. Please go to the scouting app and prepare to scout!",
          to: user.user_phone,
          from: twilio_phone,
          )
        sleep 1.5
      end
    end

    respond_to do |format|
      format.json { render json: { success: success } }
      format.turbo_stream { render json: { success: success } }
    end
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
