class TeamLogsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_team, only: %i[
  show
  edit
  create
]
  before_action :set_team_log, only: %i[
  show
  edit
]

  def show
  end

  def edit
  end

  def create
    @team_log = TeamLog.new(
      team: @team,
      log: params[:team_log][:log]
    )

    respond_to do |format|
      if @team_log.save
        format.html { redirect_to team_log_url(@team_log), notice: "Match was successfully created." }
        format.json { render :show, status: :created, location: @team_log }
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            "toggle_new",
            partial: "teams/team_log",
            locals: { team_log: @team_log, team: @team, markdown: Redcarpet::Markdown.new(Redcarpet::Render::HTML) }
          )
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team_log.errors, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            "toggle_new",
            partial: "teams/team_log",
            locals: { team_log: TeamLog.new(team: @team), team: @team, markdown: Redcarpet::Markdown.new(Redcarpet::Render::HTML) }
          )
        end
      end
    end
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_team_log
    @team_log = TeamLog.find(params[:id])
  end

  def team_log_params
    params.require(:team_log).permit(:team_id, :alliance_id, :log)
  end
end
