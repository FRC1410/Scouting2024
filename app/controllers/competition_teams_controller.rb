class CompetitionTeamsController < ApplicationController
  before_action :set_competition, only: %i[index new create destroy]

  # GET /competitions or /competitions.json
  def index
    @teams = @competition.teams
    @title = "#{@competition.name} Participating Teams"
    render "teams/index"
  end

  # GET /competitions/new
  def new
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

  def destroy
    @competition.destroy!

    respond_to do |format|
      format.html { redirect_to competitions_url, notice: "Competition was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_competition
    @competition = Competition.find(params[:competition_id])
  end
end
