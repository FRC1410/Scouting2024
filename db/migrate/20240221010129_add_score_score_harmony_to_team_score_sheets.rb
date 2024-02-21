class AddScoreScoreHarmonyToTeamScoreSheets < ActiveRecord::Migration[7.1]
  def change
    change_table :team_score_sheets do |table|
      table.integer :score_harmony, default: 0
    end
    remove_column :team_score_sheets, :harmony
  end
end
