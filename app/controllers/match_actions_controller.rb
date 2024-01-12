class MatchActionsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_match_action, only: %i[
  show
  edit
  update
  destroy
  score_amp
  score_speaker
  score_amp_auto
  score_speaker_auto
  score_trap
  leave
  toggle_auto
]

  # GET /match_actions or /match_actions.json
  def index
    @match_actions = MatchAction.all
  end

  # GET /match_actions/1 or /match_actions/1.json
  def show
  end

  # GET /match_actions/new
  def new
    @match_action = MatchAction.new
  end

  # GET /match_actions/1/edit
  def edit
  end

  # POST /match_actions or /match_actions.json
  def create
    @match_action = MatchAction.new(match_action_params)

    respond_to do |format|
      if @match_action.save
        format.html { redirect_to match_action_url(@match_action), notice: "Match action was successfully created." }
        format.json { render :show, status: :created, location: @match_action }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @match_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /match_actions/1 or /match_actions/1.json
  def update
    respond_to do |format|
      if @match_action.update(match_action_params)
        format.html { redirect_to match_action_url(@match_action), notice: "Match action was successfully updated." }
        format.json { render :show, status: :ok, location: @match_action }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @match_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /match_actions/1 or /match_actions/1.json
  def destroy
    @match_action.destroy!

    respond_to do |format|
      format.html { redirect_to match_actions_url, notice: "Match action was successfully destroyed." }
      format.json { head :no_content }
    end
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
    @match_action.leave = !@match_action.leave?
    @match_action.save
    render_turbo(:leave)
  end

  def toggle_auto
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "toggle_auto",
          partial: "match_actions/#{params[:show_section]}_section",
          locals: { match: @match, match_action: @match_action }
        )
      end
    end
  end

  private

  def score(location)
    @match_action[location] = @match_action[location].to_i + params[:increment].to_i

    if @match_action[location].to_i <= 0
      @match_action[location] = 0
    end

    @match_action.save
    render_turbo(location)
  end

  def render_turbo(location)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          dom_id(@match_action, location),
          body: @match_action[location],
          locals: { match: @match, match_action: @match_action }
        )
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_match_action
    @match_action = MatchAction.find(params[:id])
    @match = @match_action.match
  end

  # Only allow a list of trusted parameters through.
  def match_action_params
    params.require(:match_action).permit(:match_id, :team_id, :action_id, :score)
  end
end
