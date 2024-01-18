class AddTeamLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :team_logs do |t|
      t.text :log
      t.references :team, null: false, foreign_key: true
      t.references :alliance, null: true, foreign_key: true

      t.timestamps
    end
  end
end
