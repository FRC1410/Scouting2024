class AddTeamScoreSheet < ActiveRecord::Migration[7.1]
  def change
    rename_table :alliance_teams, :team_score_sheets

    change_table :team_score_sheets do |t|
      t.boolean :leave, default: false
      t.integer :score_speaker_auto, default: 0
      t.integer :score_amp_auto, default: 0
      t.integer :score_speaker, default: 0
      t.integer :score_amp, default: 0
      t.integer :score_trap, default: 0
      t.boolean :park, default: false
      t.boolean :onstage, default: false
      t.boolean :onstage_hinote, default: false
      t.boolean :harmony, default: false
    end
  end
end
