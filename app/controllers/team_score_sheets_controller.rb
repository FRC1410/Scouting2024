class TeamScoreSheetsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_team_score_sheet, only: %i[
  show
  edit
  score_amp
  score_speaker
  score_amp_auto
  score_speaker_auto
  score_trap
  leave
  toggle_auto
]

  def show
  end

  def edit
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

  def score_trap
    score(:score_trap)
  end

  def score_amp
    score(:score_amp)
  end

  def leave
    @team_score_sheet.leave = !@team_score_sheet.leave?
    @team_score_sheet.save
    render_turbo(:leave)
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

  private

  def score(location)
    @team_score_sheet[location] = @team_score_sheet[location].to_i + params[:increment].to_i

    if @team_score_sheet[location].to_i <= 0
      @team_score_sheet[location] = 0
    end

    @team_score_sheet.save
    render_turbo(location)
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
    @team_score_sheet = TeamScoreSheet.find(params[:id])
    @match = Match.find(params[:match_id])
  end

  def team_score_sheet_params
    params.require(:team_score_sheet).permit(:match_id, :team_id, :action_id, :score)
  end
end
