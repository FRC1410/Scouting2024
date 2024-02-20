class TeamLogsCanHaveScoreSheets < ActiveRecord::Migration[7.1]
  def change
    change_table :team_logs do |table|
      table.references :team_score_sheet, null: true
    end
  end
end
