class AddCurrentlyLockedToTeamScoreSheet < ActiveRecord::Migration[7.1]
  def change
    change_table :team_score_sheets do |table|
      table.boolean :currently_locked, default: false
      table.boolean :scouting_complete, default: false
    end
  end
end
