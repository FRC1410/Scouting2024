class AddShuttleToTeamScoresheet < ActiveRecord::Migration[7.1]
  def change
    add_column :team_score_sheets, :score_shuttle, :integer, :default => 0
  end
end
