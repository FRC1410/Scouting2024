class AddLastFieldsToScoreSheet < ActiveRecord::Migration[7.1]
  def change
    add_column :team_score_sheets, :foul, :integer, :default => 0
    add_column :team_score_sheets, :defended, :boolean, :default => false
    add_column :team_score_sheets, :dead_on_field, :boolean, :default => false
    remove_column :team_score_sheets, :onstage_hinote
  end
end
