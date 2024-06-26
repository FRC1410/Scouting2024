class TeamScoreSheetsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_team_score_sheet, only: %i[
  show
  edit
  leave
  park
  onstage
  defended
  dead_on_field
  toggle_auto
  toggle_teleop
  scouting_complete
  assign_scout
]

  def show
  end

  def edit
    @team_score_sheet.update!(user: @user)
    @team_score_sheet.update!(currently_locked: true)
    @match.broadcast_update_to(
      "team_score_sheets",
      target: "teams_for_#{dom_id(@team_score_sheet)}",
      partial: 'matches/match_team_list',
      locals: {
        user: @user,
        match: @match,
        locked: true,
        team_score_sheet: @team_score_sheet,
        red: params[:red] == "true"
      }
    )
  end

  def score_amp_auto
    score(:score_amp_auto)
  end

  def score_speaker_auto
    score(:score_speaker_auto)
  end

  def score_speaker
    score(:score_speaker)
  end

  def park
    @team_score_sheet.park = !@team_score_sheet.park?
    @team_score_sheet.save
    render_turbo(:park)
  end

  def score_trap
    score(:score_trap)
  end

  def score_amp
    score(:score_amp)
  end

  def score_shuttle
    score(:score_shuttle)
  end

  def onstage
    @team_score_sheet.onstage = !@team_score_sheet.onstage?
    @team_score_sheet.save
    render_turbo(:onstage)
  end

  def leave
    @team_score_sheet.leave = !@team_score_sheet.leave?
    @team_score_sheet.save
    render_turbo(:leave)
  end

  def defended
    @team_score_sheet.defended = !@team_score_sheet.defended?
    @team_score_sheet.save
    render_turbo(:defended)
  end

  def dead_on_field
    @team_score_sheet.dead_on_field = !@team_score_sheet.dead_on_field
    @team_score_sheet.save
    render_turbo(:dead_on_field)
  end

  def foul
    score(:foul)
  end

  def score_harmony
    current_score = TeamScoreSheet.where(id: params[:id]).pluck(:score_harmony).first
    increment = params[:increment].to_i
    new_score = current_score + increment
    if new_score >= 3 || new_score < 0
      new_score = current_score
    else
      TeamScoreSheet.where(id: params[:id]).update_all(" #{:score_harmony} = #{new_score}")
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          :score_harmony,
          body: new_score,
        )
      end
    end
  end

  def toggle_auto
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "toggle_auto",
          partial: "team_score_sheets/#{params[:show_section]}_section",
          locals: { match: @match, team_score_sheet: @team_score_sheet }
        )
      end
    end
  end

  def toggle_teleop
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "toggle_auto",
          partial: "team_score_sheets/#{params[:show_section]}_section",
          locals: {
            match: @match,
            team_score_sheet: @team_score_sheet,
            team: @team_score_sheet.team,
            team_log: @team_score_sheet.team_log || @team_score_sheet.build_team_log(team: @team_score_sheet.team),
            markdown: Redcarpet::Markdown.new(Redcarpet::Render::HTML),
          }
        )
      end
    end
  end

  def scouting_complete
    @team_score_sheet.update!(currently_locked: false)
    @team_score_sheet.update!(scouting_complete: true)

    if @match.red_alliance.team_score_sheets.pluck(:scouting_complete).all? && @match.blue_alliance.team_score_sheets.pluck(:scouting_complete).all?
      @match.update(completed: true)
    end

    @match.broadcast_update_to(
      "team_score_sheets",
      target: "teams_for_#{dom_id(@team_score_sheet)}",
      partial: 'matches/match_team_list',
      locals: {
        user: @user,
        match: @match,
        locked: false,
        team_score_sheet: @team_score_sheet,
        red: true
      }
    )

    redirect_to competition_matches_path(@match.competition)
  end

  def assign_scout
    @team_score_sheet.update!(user: User.find(params[:team_score_sheet][:user_id]))
    @match.broadcast_update_to(
      "team_score_sheets",
      target: "teams_for_#{dom_id(@team_score_sheet)}",
      partial: 'matches/match_team_list',
      locals: {
        user: @user,
        match: @match,
        locked: @team_score_sheet.currently_locked,
        team_score_sheet: @team_score_sheet,
        red: params[:team_score_sheet][:red] == "true"
      }
    )
  end

  private

  def score(location)
    current_score = TeamScoreSheet.where(id: params[:id]).pluck(location).first

    increment = params[:increment].to_i

    new_score = current_score + increment

    if new_score >= 0
      TeamScoreSheet.where(id: params[:id]).update_all("#{location} = #{new_score}")
    else
      new_score = current_score
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          location,
          body: new_score,
        )
      end
    end
  end

  def render_turbo(location)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          dom_id(@team_score_sheet, location),
          body: @team_score_sheet[location],
          locals: { match: @match, team_score_sheet: @team_score_sheet }
        )
      end
    end
  end

  def set_team_score_sheet
    @nonav = true
    @team_score_sheet = TeamScoreSheet.find(params[:id])
    @match = Match.find(params[:match_id])
  end

  def team_score_sheet_params
    params.require(:team_score_sheet).permit(:match_id, :team_id, :action_id, :score, :user_id)
  end
end
