class PrizesController < ApplicationController
  before_action :set_competition
  before_action :set_prize, only: %i[ destroy ]

  # GET /matches or /matches.json
  def index
    @prizes = Prize.all
  end

  def show
  end

  def new
    user_ids = []
    @competition.matches.each do |match|
      match.team_score_sheets.where(scouting_complete: true).where('team_score_sheets.updated_at > ?', Prize.maximum(:updated_at) || Date.new(2024, 01, 01)).order("RANDOM()").map do |team_score_sheet|
        user_ids << team_score_sheet.user_id
      end
    end

    user_ids = user_ids.uniq.filter(&:present?).sample(2)

    @users = User.where(id: user_ids)
    @prize = Prize.new
  end

  def create
    @prize = Prize.new(users: User.find(prize_params[:users]))

    respond_to do |format|
      if @prize.save
        format.html { redirect_to competition_prizes_path(@competition), notice: "Lottery results saved" }
        format.json { render :show, status: :created, location: @prize }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prize.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @prize.destroy!
    redirect_to competition_prizes_path(@competition)
  end

  private

  def set_prize
    @prize = Prize.find(params[:id])
  end

  def set_competition
    @competition = Competition.find(params[:competition_id])
  end

  def prize_params
    params.require(:prize).permit(users: [])
  end
end
