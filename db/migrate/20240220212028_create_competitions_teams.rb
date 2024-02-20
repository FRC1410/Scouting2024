class CreateCompetitionsTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :competition_teams do |t|
      t.references :competition, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
