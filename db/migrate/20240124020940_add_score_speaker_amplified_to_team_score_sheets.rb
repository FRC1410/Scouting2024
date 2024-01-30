class AddScoreSpeakerAmplifiedToTeamScoreSheets < ActiveRecord::Migration[7.1]
  def change
    add_column :team_score_sheets, :score_speaker_amplified, :integer, :default => 0
  end
end
