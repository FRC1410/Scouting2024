class AddScoreScoreHarmonyToTeamScoreSheets < ActiveRecord::Migration[7.1]
  def change
    change_column :team_score_sheets, :score_harmony, :integer, :default => 0
  end
end
