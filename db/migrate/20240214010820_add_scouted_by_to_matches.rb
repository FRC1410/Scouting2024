class AddScoutedByToMatches < ActiveRecord::Migration[7.1]
  def change
    change_table :team_score_sheets do |table|
      table.references :user, null: true, foreign_key: true
    end
  end
end
